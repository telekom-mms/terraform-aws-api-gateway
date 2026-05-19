// main.tf
# Written by Marc Straubinger - Overhauled for Security-First Best Practices

# CloudWatch Log Group for API Gateway Access Logs
# PSA Compliance: Req 15 (Logging is mandatory)
resource "aws_cloudwatch_log_group" "api_gateway_logs" {
  count             = var.enable_logging ? 1 : 0
  name              = "/aws/apigateway/${local.api_name}"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.kms_key_arn

  tags = merge(local.common_tags, {
    "Name"          = "/aws/apigateway/${local.api_name}"
    "PSA-Compliant" = "true"
  })
}

# IAM Role for API Gateway logging
resource "aws_iam_role" "api_gateway_cloudwatch_role" {
  count = var.enable_logging ? 1 : 0
  name  = "${local.api_name}-cloudwatch-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(local.common_tags, {
    "Name"          = "${local.api_name}-cloudwatch-role"
    "PSA-Compliant" = "true"
  })
}

# IAM Role Policy for API Gateway logging
resource "aws_iam_role_policy_attachment" "api_gateway_cloudwatch_policy" {
  count      = var.enable_logging ? 1 : 0
  role       = aws_iam_role.api_gateway_cloudwatch_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

# API Gateway Account configuration
# Note: This is global per region/account, might cause conflicts if used in multiple modules
resource "aws_api_gateway_account" "this" {
  count               = var.enable_logging && var.manage_api_gateway_account ? 1 : 0
  cloudwatch_role_arn = aws_iam_role.api_gateway_cloudwatch_role[0].arn
}

# API Gateway REST API
resource "aws_api_gateway_rest_api" "this" {
  name                     = local.api_name
  description              = var.api_description != "" ? var.api_description : "API Gateway for ${var.project_name} ${var.environment}"
  binary_media_types       = var.binary_media_types
  minimum_compression_size = var.minimum_compression_size
  api_key_source           = var.api_key_source

  endpoint_configuration {
    types = [var.endpoint_type]
  }

  # PSA Compliance: Higher security by forcing custom domain if requested
  disable_execute_api_endpoint = var.disable_execute_api_endpoint

  tags = merge(local.common_tags, {
    "Name"          = local.api_name
    "PSA-Compliant" = "true"
  })
}

# API Gateway CORS configuration
resource "aws_api_gateway_gateway_response" "cors" {
  count         = var.cors_configuration != null ? 1 : 0
  rest_api_id   = aws_api_gateway_rest_api.this.id
  response_type = "DEFAULT_4XX"

  response_templates = {
    "application/json" = jsonencode({
      message = "$context.error.messageString"
    })
  }

  response_parameters = var.cors_configuration != null ? {
    "gatewayresponse.header.Access-Control-Allow-Origin"  = "'${join(",", var.cors_configuration.allow_origins != null ? var.cors_configuration.allow_origins : ["*"])}'"
    "gatewayresponse.header.Access-Control-Allow-Headers" = "'${join(",", var.cors_configuration.allow_headers != null ? var.cors_configuration.allow_headers : ["Content-Type", "X-Amz-Date", "Authorization", "X-Api-Key"])}'"
    "gatewayresponse.header.Access-Control-Allow-Methods" = "'${join(",", var.cors_configuration.allow_methods != null ? var.cors_configuration.allow_methods : ["GET", "POST", "PUT", "DELETE", "OPTIONS"])}'"
  } : {}
}

# API Gateway Deployment
resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  # Note: Trigger deployment on changes to resources/methods (not shown here as they are usually external)
  # In a real scenario, use a trigger based on the OpenAPI spec or resources
  # triggers = {
  #   redeployment = sha1(jsonencode([
  #     aws_api_gateway_rest_api.this.body,
  #   ]))
  # }

  lifecycle {
    create_before_destroy = true
  }
}

# API Gateway Stage
resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = var.stage_name
  description   = var.stage_description != "" ? var.stage_description : "Stage for ${var.project_name} ${var.environment}"

  xray_tracing_enabled = var.enable_xray_tracing

  dynamic "access_log_settings" {
    for_each = var.enable_logging ? [1] : []
    content {
      destination_arn = aws_cloudwatch_log_group.api_gateway_logs[0].arn
      # JSON format for better security analysis and compliance auditing
      format = jsonencode({
        requestId      = "$context.requestId"
        ip             = "$context.identity.sourceIp"
        caller         = "$context.identity.caller"
        user           = "$context.identity.user"
        requestTime    = "$context.requestTime"
        httpMethod     = "$context.httpMethod"
        resourcePath   = "$context.resourcePath"
        status         = "$context.status"
        protocol       = "$context.protocol"
        responseLength = "$context.responseLength"
        userAgent      = "$context.identity.userAgent"
        # PSA compliance fields
        principalId = "$context.authorizer.principalId"
        error       = "$context.error.message"
        wafResponse = "$context.wafResponseCode"
      })
    }
  }

  tags = merge(local.common_tags, {
    "Name"          = "${local.api_name}-${var.stage_name}"
    "PSA-Compliant" = "true"
  })
}

# API Gateway Method Settings
resource "aws_api_gateway_method_settings" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = aws_api_gateway_stage.this.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled        = var.metrics_enabled
    logging_level          = var.logging_level
    data_trace_enabled     = false # Secure by default: don't log full payload
    throttling_rate_limit  = var.throttle_rate_limit
    throttling_burst_limit = var.throttle_burst_limit
  }
}

# WAF Association
# PSA Compliance: Essential layer 7 protection
resource "aws_wafv2_web_acl_association" "this" {
  count        = var.waf_web_acl_arn != "" ? 1 : 0
  resource_arn = aws_api_gateway_stage.this.arn
  web_acl_arn  = var.waf_web_acl_arn
}

# Usage Plan
resource "aws_api_gateway_usage_plan" "this" {
  count       = var.create_usage_plan ? 1 : 0
  name        = local.usage_plan_name
  description = var.usage_plan_description != "" ? var.usage_plan_description : "Usage plan for ${var.project_name} ${var.environment}"

  api_stages {
    api_id = aws_api_gateway_rest_api.this.id
    stage  = aws_api_gateway_stage.this.stage_name
  }

  quota_settings {
    limit  = var.usage_plan_quota_limit
    period = var.usage_plan_quota_period
  }

  throttle_settings {
    rate_limit  = var.throttle_rate_limit
    burst_limit = var.throttle_burst_limit
  }

  tags = merge(local.common_tags, {
    "Name"          = local.usage_plan_name
    "PSA-Compliant" = "true"
  })
}

# API Key
resource "aws_api_gateway_api_key" "this" {
  count       = var.create_api_key ? 1 : 0
  name        = local.api_key_name
  description = var.api_key_description != "" ? var.api_key_description : "API key for ${var.project_name} ${var.environment}"
  enabled     = true

  tags = merge(local.common_tags, {
    "Name"          = local.api_key_name
    "PSA-Compliant" = "true"
  })
}

# Usage Plan Key
resource "aws_api_gateway_usage_plan_key" "this" {
  count         = var.create_usage_plan && var.create_api_key ? 1 : 0
  key_id        = aws_api_gateway_api_key.this[0].id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.this[0].id
}
