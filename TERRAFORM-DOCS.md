<!-- BEGIN_TF_DOCS -->


## Requirements

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.100.0 |

## Resources

## Resources

| Name | Type |
|------|------|
| [aws_api_gateway_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_account) | resource |
| [aws_api_gateway_api_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_api_key) | resource |
| [aws_api_gateway_deployment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment) | resource |
| [aws_api_gateway_gateway_response.cors](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_gateway_response) | resource |
| [aws_api_gateway_method_settings.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method_settings) | resource |
| [aws_api_gateway_rest_api.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api) | resource |
| [aws_api_gateway_stage.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage) | resource |
| [aws_api_gateway_usage_plan.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_usage_plan) | resource |
| [aws_api_gateway_usage_plan_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_usage_plan_key) | resource |
| [aws_cloudwatch_log_group.api_gateway_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.api_gateway_cloudwatch_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.api_gateway_cloudwatch_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_wafv2_web_acl_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |

## Inputs

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g., prod, dev, test) | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |
| <a name="input_api_description"></a> [api\_description](#input\_api\_description) | Description of the API Gateway | `string` | `""` | no |
| <a name="input_api_key_description"></a> [api\_key\_description](#input\_api\_key\_description) | Description of the API key | `string` | `""` | no |
| <a name="input_api_key_name"></a> [api\_key\_name](#input\_api\_key\_name) | Name of the API key | `string` | `""` | no |
| <a name="input_api_key_source"></a> [api\_key\_source](#input\_api\_key\_source) | Source of the API key for requests (HEADER, AUTHORIZER) | `string` | `"HEADER"` | no |
| <a name="input_binary_media_types"></a> [binary\_media\_types](#input\_binary\_media\_types) | List of binary media types supported by the API | `list(string)` | `[]` | no |
| <a name="input_cors_configuration"></a> [cors\_configuration](#input\_cors\_configuration) | CORS configuration for API Gateway | <pre>object({<br/>    allow_credentials = optional(bool)<br/>    allow_headers     = optional(list(string))<br/>    allow_methods     = optional(list(string))<br/>    allow_origins     = optional(list(string))<br/>    expose_headers    = optional(list(string))<br/>    max_age           = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_create_api_key"></a> [create\_api\_key](#input\_create\_api\_key) | Create API key for the usage plan | `bool` | `false` | no |
| <a name="input_create_usage_plan"></a> [create\_usage\_plan](#input\_create\_usage\_plan) | Create API usage plan | `bool` | `true` | no |
| <a name="input_disable_execute_api_endpoint"></a> [disable\_execute\_api\_endpoint](#input\_disable\_execute\_api\_endpoint) | Disable the default execute-api endpoint (forces use of custom domain) | `bool` | `true` | no |
| <a name="input_enable_logging"></a> [enable\_logging](#input\_enable\_logging) | Enable API Gateway logging | `bool` | `true` | no |
| <a name="input_enable_xray_tracing"></a> [enable\_xray\_tracing](#input\_enable\_xray\_tracing) | Enable X-Ray tracing for API Gateway | `bool` | `true` | no |
| <a name="input_endpoint_type"></a> [endpoint\_type](#input\_endpoint\_type) | Type of API endpoint (EDGE, REGIONAL, PRIVATE) | `string` | `"REGIONAL"` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | KMS key ARN for CloudWatch log group encryption | `string` | `""` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | CloudWatch log retention in days | `number` | `30` | no |
| <a name="input_logging_level"></a> [logging\_level](#input\_logging\_level) | Logging level for the API Gateway (OFF, ERROR, INFO) | `string` | `"INFO"` | no |
| <a name="input_manage_api_gateway_account"></a> [manage\_api\_gateway\_account](#input\_manage\_api\_gateway\_account) | Whether this module should manage the global API Gateway account settings. Set to false if another module or resource already manages this. | `bool` | `true` | no |
| <a name="input_metrics_enabled"></a> [metrics\_enabled](#input\_metrics\_enabled) | Indicates whether Amazon CloudWatch metrics are enabled for this stage | `bool` | `true` | no |
| <a name="input_minimum_compression_size"></a> [minimum\_compression\_size](#input\_minimum\_compression\_size) | Minimum response size to compress (in bytes) | `number` | `1024` | no |
| <a name="input_mtls_enabled"></a> [mtls\_enabled](#input\_mtls\_enabled) | Whether to enable mutual TLS authentication (requires custom domain) | `bool` | `false` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for resource names (if not provided, will use project-environment pattern) | `string` | `""` | no |
| <a name="input_stage_description"></a> [stage\_description](#input\_stage\_description) | Description of the deployment stage | `string` | `""` | no |
| <a name="input_stage_name"></a> [stage\_name](#input\_stage\_name) | Name of the deployment stage | `string` | `"prod"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags for all resources | `map(string)` | `{}` | no |
| <a name="input_throttle_burst_limit"></a> [throttle\_burst\_limit](#input\_throttle\_burst\_limit) | Throttle burst limit for API requests | `number` | `500` | no |
| <a name="input_throttle_rate_limit"></a> [throttle\_rate\_limit](#input\_throttle\_rate\_limit) | Throttle rate limit for API requests per second | `number` | `1000` | no |
| <a name="input_truststore_uri"></a> [truststore\_uri](#input\_truststore\_uri) | S3 URI of the truststore (required if mtls\_enabled is true) | `string` | `""` | no |
| <a name="input_truststore_version"></a> [truststore\_version](#input\_truststore\_version) | Version of the truststore object in S3 | `string` | `""` | no |
| <a name="input_usage_plan_description"></a> [usage\_plan\_description](#input\_usage\_plan\_description) | Description of the usage plan | `string` | `""` | no |
| <a name="input_usage_plan_name"></a> [usage\_plan\_name](#input\_usage\_plan\_name) | Name of the usage plan | `string` | `""` | no |
| <a name="input_usage_plan_quota_limit"></a> [usage\_plan\_quota\_limit](#input\_usage\_plan\_quota\_limit) | Maximum number of requests per period | `number` | `5000` | no |
| <a name="input_usage_plan_quota_period"></a> [usage\_plan\_quota\_period](#input\_usage\_plan\_quota\_period) | Quota period (DAY, WEEK, MONTH) | `string` | `"DAY"` | no |
| <a name="input_waf_web_acl_arn"></a> [waf\_web\_acl\_arn](#input\_waf\_web\_acl\_arn) | ARN of the WAF Web ACL to associate with the API Gateway | `string` | `""` | no |

## Outputs

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_arn"></a> [api\_arn](#output\_api\_arn) | ARN of the API Gateway REST API |
| <a name="output_api_execution_arn"></a> [api\_execution\_arn](#output\_api\_execution\_arn) | Execution ARN of the API Gateway REST API |
| <a name="output_api_id"></a> [api\_id](#output\_api\_id) | ID of the API Gateway REST API |
| <a name="output_api_key_id"></a> [api\_key\_id](#output\_api\_key\_id) | ID of the API Gateway API key |
| <a name="output_api_key_name"></a> [api\_key\_name](#output\_api\_key\_name) | Name of the API Gateway API key |
| <a name="output_api_key_value"></a> [api\_key\_value](#output\_api\_key\_value) | Value of the API Gateway API key |
| <a name="output_api_name"></a> [api\_name](#output\_api\_name) | Name of the API Gateway REST API |
| <a name="output_api_root_resource_id"></a> [api\_root\_resource\_id](#output\_api\_root\_resource\_id) | Root resource ID of the API Gateway REST API |
| <a name="output_cloudwatch_log_group_arn"></a> [cloudwatch\_log\_group\_arn](#output\_cloudwatch\_log\_group\_arn) | ARN of the CloudWatch log group for API Gateway |
| <a name="output_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#output\_cloudwatch\_log\_group\_name) | Name of the CloudWatch log group for API Gateway |
| <a name="output_deployment_id"></a> [deployment\_id](#output\_deployment\_id) | ID of the API Gateway deployment |
| <a name="output_stage_arn"></a> [stage\_arn](#output\_stage\_arn) | ARN of the API Gateway stage |
| <a name="output_stage_invoke_url"></a> [stage\_invoke\_url](#output\_stage\_invoke\_url) | Invoke URL of the API Gateway stage |
| <a name="output_stage_name"></a> [stage\_name](#output\_stage\_name) | Name of the API Gateway stage |
| <a name="output_usage_plan_id"></a> [usage\_plan\_id](#output\_usage\_plan\_id) | ID of the API Gateway usage plan |
| <a name="output_usage_plan_name"></a> [usage\_plan\_name](#output\_usage\_plan\_name) | Name of the API Gateway usage plan |
<!-- END_TF_DOCS -->