# AWS API Gateway Basic Example

This example demonstrates how to use the AWS API Gateway module to create a basic REST API with a usage plan and API key.

## Features

- Basic API Gateway REST API
- Regional endpoint
- Usage plan with default quota and throttling
- API key for access control

## Usage

1.  Copy this example to your project.
2.  Update `variables.tf` with your specific values.
3.  Initialize and apply:
    ```bash
    terraform init
    terraform plan
    terraform apply
    ```

## Variables

See `variables.tf` for all configurable options.

## Outputs

- `api_id`: ID of the created API Gateway.
- `api_invoke_url`: Invoke URL for the API Gateway.
- `api_key_value`: The generated API key (sensitive).

## Requirements

- AWS CLI configured
- Terraform >= 1.0
