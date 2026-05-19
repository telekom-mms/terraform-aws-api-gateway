// examples/api-basic/main.tf

provider "aws" {
  region = "eu-central-1"
}

module "api_gateway" {
  source = "registry.terraform.io/telekom-mms/api-gateway/aws"

  name_prefix = "api-gatewaymms"

  api_description = "Basic API Gateway for example application"
  endpoint_type   = "REGIONAL"

  create_usage_plan = true
  create_api_key    = true

  tags = var.tags
}
