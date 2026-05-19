<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a id="readme-top"></a>

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![Unlicense License][license-shield]][license-url]

<br />

<!-- PROJECT LOGO -->
<div align="center">
  <a href="https://github.com/telekom-mms/terraform-aws-api-gateway">
    <img src="logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">AWS API Gateway Module</h3>

  <p align="center">
    PSA-compliant AWS API Gateway with WAF integration, mTLS support, and comprehensive logging.
    <br />
    <a href="https://github.com/telekom-mms/terraform-aws-api-gateway"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/telekom-mms/terraform-aws-api-gateway">View Demo</a>
    ·
    <a href="https://github.com/telekom-mms/terraform-aws-api-gateway/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/telekom-mms/terraform-aws-api-gateway/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>

## Documentation

Full auto-generated documentation of inputs, outputs, and resources: [TERRAFORM-DOCS.md](TERRAFORM-DOCS.md)

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#features">Features</a></li>
        <li><a href="#opentofu-compatibility">OpenTofu Compatibility</a></li>
        <li><a href="#psa-compliance">PSA Compliance</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#environment-files">Environment Files</a></li>
    <li><a href="#examples">Examples</a></li>
    <li><a href="#security-features">Security Features</a></li>
    <li><a href="#outputs">Outputs</a></li>
    <li><a href="#psa-compliance-features">PSA Compliance Features</a></li>
    <li><a href="#integration">Integration</a></li>
    <li><a href="#troubleshooting">Troubleshooting</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

This Terraform module creates PSA-compliant AWS API Gateways with mandatory logging, WAF integration, and strict throttling limits. It is designed to be "secure by default" while offering flexibility for complex deployments including mTLS and private endpoints.

### Features

- **Regional Endpoints**: Defaulted to Regional for WAF support and lower latency.
- **WAF Integration**: Native support for associating Web ACLs.
- **mTLS Support**: Optional mutual TLS authentication with S3-backed truststores.
- **Enhanced Logging**: JSON-formatted access logs with comprehensive context fields.
- **KMS Encryption**: CloudWatch log group encryption.
- **Usage Plans & Keys**: Integrated management for API quotas and throttling.
- **X-Ray Tracing**: Enabled by default for observability.
- **CORS Configuration**: Simplified CORS setup via variable object.

### OpenTofu Compatibility

This module is designed to work with both Terraform and OpenTofu. The module uses standard HCL syntax that is compatible with both tools, ensuring seamless integration regardless of which infrastructure-as-code tool you choose.

### PSA Compliance

PSA compliance is an internal best practice that is automatically enforced by this module. All resources created by this module automatically adhere to PSA compliance standards (e.g., Req 15 for logging, Req 7 for strong AuthN) without requiring any additional configuration.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

- Terraform v1.3 or higher
- AWS CLI configured with appropriate permissions

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/telekom-mms/terraform-aws-api-gateway.git
   ```
2. Navigate to the module directory
   ```sh
   cd terraform-aws-api-gateway
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE -->
## Usage

This module can be used with or without environment files. Below are examples of both approaches.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ENVIRONMENT FILES -->
## Environment Files

The module supports environment-specific configuration through external environment files.

1. **Template File**: A template file `env-template.tfvars` is provided in the `env/` directory.
2. **Creating Environment Files**: Copy `env-template.tfvars` to `env/env-<environment>.tfvars`.
3. **Using Environment Files**: Specify the environment file via the `-var-file` parameter.

```hcl
module "api_gateway" {
  source = "./terraform-aws-api-gateway"

  # Required variables
  project_name = "myapp"
  environment  = "prod"
  
  # API Configuration
  api_description = "Core API for MyApp"
  endpoint_type   = "REGIONAL"
  
  # Security
  create_api_key    = true
  create_usage_plan = true
  waf_web_acl_arn   = "arn:aws:wafv2:region:account:regional/webacl/name/id"
}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- EXAMPLES -->
## Examples

### Basic Usage

```hcl
module "api_gateway" {
  source = "./terraform-aws-api-gateway"

  project_name = "demo"
  environment  = "dev"
  
  api_description = "Demo API"
  
  cors_configuration = {
    allow_origins = ["*"]
    allow_methods = ["GET", "POST"]
  }
}
```

### Advanced Usage with mTLS and WAF

```hcl
module "api_gateway" {
  source = "./terraform-aws-api-gateway"

  project_name = "secure-app"
  environment  = "prod"
  
  # Security
  waf_web_acl_arn = "arn:aws:wafv2:us-east-1:123456789012:regional/webacl/my-acl/..."
  kms_key_arn     = "arn:aws:kms:us-east-1:123456789012:key/..."
  
  # mTLS
  mtls_enabled       = true
  truststore_uri     = "s3://my-truststore-bucket/truststore.pem"
  truststore_version = "v1"
  disable_execute_api_endpoint = true
  
  # Throttling
  throttle_rate_limit  = 2000
  throttle_burst_limit = 1000
}
```

## Outputs

| Name | Description |
|------|-------------|
| `api_id` | ID of the API Gateway REST API |
| `api_arn` | ARN of the API Gateway REST API |
| `api_execution_arn` | Execution ARN of the API Gateway REST API |
| `stage_invoke_url` | Invoke URL of the API Gateway stage |
| `api_key_value` | Value of the API Gateway API key (sensitive) |
| `cloudwatch_log_group_arn` | ARN of the CloudWatch log group |

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SECURITY FEATURES -->
## Security Features

- **WAF Association**: Direct integration with AWS WAFv2 Web ACLs.
- **mTLS Support**: Mutual TLS authentication using S3-backed truststores.
- **Encrypted Logging**: CloudWatch logs encrypted with customer-managed KMS keys.
- **Private Endpoints**: Support for PRIVATE endpoint types with VPC Endpoints.
- **Throttling**: Strict default rate and burst limits to prevent DoS.
- **Disable Default Endpoint**: Option to disable the default `execute-api` endpoint.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- PSA COMPLIANCE FEATURES -->
## PSA Compliance Features

This module implements the following PSA compliance features (referencing `14-Strukturierte_PSA_Anforderungen_WebServices_TARDIS_LLM.pdf`):

### Security Controls

- **Req 7 (Strong Auth)**: Supports mTLS and API Keys.
- **Req 15 (Logging)**: Mandatory CloudWatch access logging enabled by default.
- **Req 15 (Transport Encryption)**: Enforced via HTTPS endpoints and mTLS options.
- **Req 3 (DoS Protection)**: Throttling limits enforced via Usage Plans.
- **Req 1 (Vulnerability Management)**: Integration with WAF for exploit protection.

### Monitoring & Logging

- **JSON Logging**: Access logs formatted in JSON for automated analysis.
- **X-Ray**: Active tracing enabled by default.
- **Metrics**: Detailed CloudWatch metrics enabled.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- INTEGRATION -->
## Integration

### Related Modules

- [terraform-aws-waf](../terraform-aws-waf) - WAF ACL configuration
- [terraform-aws-lambda](../terraform-aws-lambda) - Lambda backends
- [terraform-aws-kms](../terraform-aws-kms) - Encryption keys

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- TROUBLESHOOTING -->
## Troubleshooting

### mTLS Issues

- Ensure the truststore is in the correct S3 bucket and region.
- Verify the S3 bucket policy allows API Gateway access.
- Check that the custom domain is correctly configured with the truststore.

### 504 Gateway Timeout

- Check backend (Lambda/HTTP) timeout settings.
- Verify security groups allow traffic from API Gateway.

### 403 Forbidden

- Verify WAF rules are not blocking the request.
- Check API Key validity if enabled.
- Confirm Resource Policy permits the caller IP/User.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->
## License

Distributed under the Mozilla Public License Version 2.0. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->
## Contact

Project Link: [https://github.com/telekom-mms/terraform-aws-api-gateway](https://github.com/telekom-mms/terraform-aws-api-gateway)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
[contributors-shield]: https://img.shields.io/github/contributors/telekom-mms/terraform-aws-api-gateway.svg?style=for-the-badge
[contributors-url]: https://github.com/telekom-mms/terraform-aws-api-gateway/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/telekom-mms/terraform-aws-api-gateway.svg?style=for-the-badge
[forks-url]: https://github.com/telekom-mms/terraform-aws-api-gateway/network/members
[stars-shield]: https://img.shields.io/github/stars/telekom-mms/terraform-aws-api-gateway.svg?style=for-the-badge
[stars-url]: https://github.com/telekom-mms/terraform-aws-api-gateway/stargazers
[issues-shield]: https://img.shields.io/github/issues/telekom-mms/terraform-aws-api-gateway.svg?style=for-the-badge
[issues-url]: https://github.com/telekom-mms/terraform-aws-api-gateway/issues
[license-shield]: https://img.shields.io/github/license/telekom-mms/terraform-aws-api-gateway.svg?style=for-the-badge
[license-url]: https://github.com/telekom-mms/terraform-aws-api-gateway/blob/master/LICENSE.txt

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

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

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
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
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g., prod, dev, test) | `string` | n/a | yes |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | KMS key ARN for CloudWatch log group encryption | `string` | `""` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | CloudWatch log retention in days | `number` | `30` | no |
| <a name="input_logging_level"></a> [logging\_level](#input\_logging\_level) | Logging level for the API Gateway (OFF, ERROR, INFO) | `string` | `"INFO"` | no |
| <a name="input_manage_api_gateway_account"></a> [manage\_api\_gateway\_account](#input\_manage\_api\_gateway\_account) | Whether this module should manage the global API Gateway account settings. Set to false if another module or resource already manages this. | `bool` | `true` | no |
| <a name="input_metrics_enabled"></a> [metrics\_enabled](#input\_metrics\_enabled) | Indicates whether Amazon CloudWatch metrics are enabled for this stage | `bool` | `true` | no |
| <a name="input_minimum_compression_size"></a> [minimum\_compression\_size](#input\_minimum\_compression\_size) | Minimum response size to compress (in bytes) | `number` | `1024` | no |
| <a name="input_mtls_enabled"></a> [mtls\_enabled](#input\_mtls\_enabled) | Whether to enable mutual TLS authentication (requires custom domain) | `bool` | `false` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for resource names (if not provided, will use project-environment pattern) | `string` | `""` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of the project | `string` | n/a | yes |
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