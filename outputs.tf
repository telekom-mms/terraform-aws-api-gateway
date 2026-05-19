// outputs.tf

output "api_id" {
  description = "ID of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.this.id
}

output "api_name" {
  description = "Name of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.this.name
}

output "api_arn" {
  description = "ARN of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.this.arn
}

output "api_root_resource_id" {
  description = "Root resource ID of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.this.root_resource_id
}

output "api_execution_arn" {
  description = "Execution ARN of the API Gateway REST API"
  value       = aws_api_gateway_rest_api.this.execution_arn
}

output "stage_name" {
  description = "Name of the API Gateway stage"
  value       = aws_api_gateway_stage.this.stage_name
}

output "stage_arn" {
  description = "ARN of the API Gateway stage"
  value       = aws_api_gateway_stage.this.arn
}

output "stage_invoke_url" {
  description = "Invoke URL of the API Gateway stage"
  value       = aws_api_gateway_stage.this.invoke_url
}

output "deployment_id" {
  description = "ID of the API Gateway deployment"
  value       = aws_api_gateway_deployment.this.id
}

output "usage_plan_id" {
  description = "ID of the API Gateway usage plan"
  value       = var.create_usage_plan ? aws_api_gateway_usage_plan.this[0].id : null
}

output "usage_plan_name" {
  description = "Name of the API Gateway usage plan"
  value       = var.create_usage_plan ? aws_api_gateway_usage_plan.this[0].name : null
}

output "api_key_id" {
  description = "ID of the API Gateway API key"
  value       = var.create_api_key ? aws_api_gateway_api_key.this[0].id : null
}

output "api_key_name" {
  description = "Name of the API Gateway API key"
  value       = var.create_api_key ? aws_api_gateway_api_key.this[0].name : null
}

output "api_key_value" {
  description = "Value of the API Gateway API key"
  value       = var.create_api_key ? aws_api_gateway_api_key.this[0].value : null
  sensitive   = true
}

output "cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group for API Gateway"
  value       = var.enable_logging ? aws_cloudwatch_log_group.api_gateway_logs[0].name : null
}

output "cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch log group for API Gateway"
  value       = var.enable_logging ? aws_cloudwatch_log_group.api_gateway_logs[0].arn : null
}
