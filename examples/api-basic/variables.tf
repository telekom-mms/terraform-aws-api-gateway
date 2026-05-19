// examples/api-basic/variables.tf

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "example-api"
}

variable "environment" {
  description = "Environment (e.g., prod, dev, test)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Tags for all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Owner       = "terraform"
    Project     = "api-example"
  }
}
