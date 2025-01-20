variable "business_unit" {
  description = "Area of the MOJ responsible for the service"
  type        = string
  default     = "Platforms"
}

variable "application" {
  description = "Application name"
  type        = string
  default     = "cloud-platform-terraform-template example module"
}

variable "is_production" {
  description = "Whether this is used for production or not"
  type        = string
  default     = "false"
}

variable "namespace" {
  description = "Namespace name"
  type        = string
  default     = "cloud-platform-terraform-template-example-module"
}

variable "environment_name" {
  description = "Environment name"
  type        = string
  default     = "non-production"
}

