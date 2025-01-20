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

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "non-production"
}

variable "github_token" {
  description = "GitHub token"
  type        = string
  default     = "cloud-platform-terraform-template-example-module"
}

variable "kubernetes_cluster" {
  description = "Kubernetes cluster name"
  type        = string
  default     = "cloud-platform-terraform-template-example-module"

}