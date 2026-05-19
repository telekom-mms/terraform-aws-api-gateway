// variables.tf

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., prod, dev, test)"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for resource names (if not provided, will use project-environment pattern)"
  type        = string
  default     = ""
}


variable "tags" {
  description = "Additional tags for all resources"
  type        = map(string)
  default     = {}
}

variable "api_description" {
  description = "Description of the API Gateway"
  type        = string
  default     = ""
}

variable "endpoint_type" {
  description = "Type of API endpoint (EDGE, REGIONAL, PRIVATE)"
  type        = string
  default     = "REGIONAL" # Best practice: Regional for most use cases (lower latency, WAF support)
  validation {
    condition     = contains(["EDGE", "REGIONAL", "PRIVATE"], var.endpoint_type)
    error_message = "Endpoint type must be one of: EDGE, REGIONAL, PRIVATE."
  }
}

variable "stage_name" {
  description = "Name of the deployment stage"
  type        = string
  default     = "prod"
}

variable "stage_description" {
  description = "Description of the deployment stage"
  type        = string
  default     = ""
}

variable "enable_logging" {
  description = "Enable API Gateway logging"
  type        = bool
  default     = true # PSA Req 15
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 30
}

variable "logging_level" {
  description = "Logging level for the API Gateway (OFF, ERROR, INFO)"
  type        = string
  default     = "INFO"
}

variable "metrics_enabled" {
  description = "Indicates whether Amazon CloudWatch metrics are enabled for this stage"
  type        = bool
  default     = true
}

variable "throttle_rate_limit" {
  description = "Throttle rate limit for API requests per second"
  type        = number
  default     = 1000
}

variable "throttle_burst_limit" {
  description = "Throttle burst limit for API requests"
  type        = number
  default     = 500
}

variable "enable_xray_tracing" {
  description = "Enable X-Ray tracing for API Gateway"
  type        = bool
  default     = true
}

variable "binary_media_types" {
  description = "List of binary media types supported by the API"
  type        = list(string)
  default     = []
}

variable "minimum_compression_size" {
  description = "Minimum response size to compress (in bytes)"
  type        = number
  default     = 1024
}

variable "api_key_source" {
  description = "Source of the API key for requests (HEADER, AUTHORIZER)"
  type        = string
  default     = "HEADER"
  validation {
    condition     = contains(["HEADER", "AUTHORIZER"], var.api_key_source)
    error_message = "API key source must be either HEADER or AUTHORIZER."
  }
}

variable "cors_configuration" {
  description = "CORS configuration for API Gateway"
  type = object({
    allow_credentials = optional(bool)
    allow_headers     = optional(list(string))
    allow_methods     = optional(list(string))
    allow_origins     = optional(list(string))
    expose_headers    = optional(list(string))
    max_age           = optional(number)
  })
  default = null
}

variable "create_usage_plan" {
  description = "Create API usage plan"
  type        = bool
  default     = true # Best practice: always use usage plans for control
}

variable "usage_plan_name" {
  description = "Name of the usage plan"
  type        = string
  default     = ""
}

variable "usage_plan_description" {
  description = "Description of the usage plan"
  type        = string
  default     = ""
}

variable "usage_plan_quota_limit" {
  description = "Maximum number of requests per period"
  type        = number
  default     = 5000
}

variable "usage_plan_quota_period" {
  description = "Quota period (DAY, WEEK, MONTH)"
  type        = string
  default     = "DAY"
  validation {
    condition     = contains(["DAY", "WEEK", "MONTH"], var.usage_plan_quota_period)
    error_message = "Usage plan quota period must be one of: DAY, WEEK, MONTH."
  }
}

variable "create_api_key" {
  description = "Create API key for the usage plan"
  type        = bool
  default     = false
}

variable "api_key_name" {
  description = "Name of the API key"
  type        = string
  default     = ""
}

variable "api_key_description" {
  description = "Description of the API key"
  type        = string
  default     = ""
}

variable "waf_web_acl_arn" {
  description = "ARN of the WAF Web ACL to associate with the API Gateway"
  type        = string
  default     = ""
}

variable "kms_key_arn" {
  description = "KMS key ARN for CloudWatch log group encryption"
  type        = string
  default     = ""
}

variable "disable_execute_api_endpoint" {
  description = "Disable the default execute-api endpoint (forces use of custom domain)"
  type        = bool
  default     = false # Set to true for higher security if using custom domains
}

variable "mtls_enabled" {
  description = "Whether to enable mutual TLS authentication (requires custom domain)"
  type        = bool
  default     = false
}

variable "truststore_uri" {
  description = "S3 URI of the truststore (required if mtls_enabled is true)"
  type        = string
  default     = ""
}

variable "truststore_version" {
  description = "Version of the truststore object in S3"
  type        = string
  default     = ""
}

