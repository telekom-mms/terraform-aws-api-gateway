locals {
  name_prefix = var.name_prefix != "" ? var.name_prefix : "${var.project_name}-${var.environment}"

  api_name        = "${local.name_prefix}-api"
  usage_plan_name = var.usage_plan_name != "" ? var.usage_plan_name : "${local.name_prefix}-usage-plan"
  api_key_name    = var.api_key_name != "" ? var.api_key_name : "${local.name_prefix}-api-key"

  common_tags = merge(var.tags, {
    "Project"       = var.project_name
    "Environment"   = var.environment
    "ManagedBy"     = "Terraform"
    "PSA-Compliant" = "true"
  })
}
