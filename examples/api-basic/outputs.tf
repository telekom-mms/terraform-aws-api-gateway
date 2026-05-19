// examples/api-basic/outputs.tf

output "api_id" {
  description = "ID of the API Gateway REST API"
  value       = module.api_gateway.api_id
}

output "api_invoke_url" {
  description = "Invoke URL of the API Gateway stage"
  value       = module.api_gateway.stage_invoke_url
}

output "api_key_value" {
  description = "Value of the API Gateway API key"
  value       = module.api_gateway.api_key_value
  sensitive   = true
}
