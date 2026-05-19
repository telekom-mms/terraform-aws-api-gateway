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
