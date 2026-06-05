#################
# Configuration #
#################

# Add module-specific variables here

variable "enable_egress_controls" {
  description = "Whether to create Calico egress policies and an Envoy HTTPS proxy deployment"
  type        = bool
  default     = false
}

variable "envoy_proxy_name" {
  description = "Base name used for the Envoy proxy resource suffix and app.kubernetes.io/name label"
  type        = string
  default     = "envoy-https-proxy"
}

variable "envoy_proxy_replicas" {
  description = "Number of Envoy proxy replicas"
  type        = number
  default     = 2
}

variable "envoy_image" {
  description = "Container image for the Envoy proxy"
  type        = string
  default     = "envoyproxy/envoy:v1.38-latest"
}

variable "envoy_log_level" {
  description = "Envoy runtime log level"
  type        = string
  default     = "info"
}

variable "envoy_proxy_port" {
  description = "Envoy forward proxy listening port"
  type        = number
  default     = 3128
}

variable "envoy_dns_host_ttl" {
  description = "TTL used for cached DNS hosts in Envoy"
  type        = string
  default     = "60s"
}

variable "envoy_connect_timeout" {
  description = "Upstream connect timeout for the dynamic forward proxy cluster"
  type        = string
  default     = "10s"
}

variable "envoy_default_allowed_hosts_exact" {
  description = "Approved exact hostnames to allow through the Envoy proxy"
  type        = list(string)
  default = [
    "sqs.eu-west-2.amazonaws.com",
    "sts.eu-west-2.amazonaws.com",
    "agent.azureserviceprofiler.net",
  ]
  validation {
    condition = alltrue([
      for host in var.envoy_default_allowed_hosts_exact : can(regex("^[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?(?:\\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)*$", host))
    ])
    error_message = "envoy_default_allowed_hosts_exact values must be DNS hostnames only (no scheme, path, wildcard, or port)."
  }
}

variable "envoy_default_allowed_hosts_suffixes" {
  description = "Approved hostname suffixes to allow through the Envoy proxy"
  type        = list(string)
  default = [
    ".in.applicationinsights.azure.com",
    ".livediagnostics.monitor.azure.com",
    ".service.justice.gov.uk",
  ]
  validation {
    condition = alltrue([
      for suffix in var.envoy_default_allowed_hosts_suffixes : can(regex("^\\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?(?:\\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)*$", suffix))
    ])
    error_message = "envoy_default_allowed_hosts_suffixes values must start with '.' and contain a valid DNS suffix (for example '.example.com')."
  }
}

variable "envoy_extra_allowed_hosts_exact" {
  description = "Additional exact hostnames to allow through the Envoy proxy, merged with the default list in envoy_default_allowed_hosts_exact"
  type        = list(string)
  default     = []
  validation {
    condition = alltrue([
      for host in var.envoy_extra_allowed_hosts_exact : can(regex("^[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?(?:\\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)*$", host))
    ])
    error_message = "envoy_extra_allowed_hosts_exact values must be DNS hostnames only (no scheme, path, wildcard, or port)."
  }
}

variable "envoy_extra_allowed_hosts_suffixes" {
  description = "Additional hostname suffixes to allow through the Envoy proxy, merged with the default list in envoy_default_allowed_hosts_suffixes"
  type        = list(string)
  default     = []
  validation {
    condition = alltrue([
      for suffix in var.envoy_extra_allowed_hosts_suffixes : can(regex("^\\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?(?:\\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)*$", suffix))
    ])
    error_message = "envoy_extra_allowed_hosts_suffixes values must start with '.' and contain a valid DNS suffix (for example '.example.com')."
  }
}

########
# Tags #
########
variable "application" {
  description = "Application name"
  type        = string
}

variable "is_production" {
  description = "Whether this is used for production or not"
  type        = string
}

variable "namespace" {
  description = "Namespace name"
  type        = string
}

variable "environment" {
  description = "Environment name - must match environment names used in helm files."
  type        = string
}

variable "kubernetes_cluster" {
  description = "The name of the Kubernetes cluster"
  type        = string
}

# application_insights_instance should be set to one of:
# "dev" (appears as t3 in azure portal) or "preprod" or "prod".
# This determines which instance of application insights metrics and logs are sent to.
variable "application_insights_instance" {
  description = "Determines which instrumentation key to use for Application Insights."
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "preprod", "prod"], var.application_insights_instance)
    error_message = "Valid values for application_insights_instance are: dev, preprod or prod."
  }
}

variable "github_repo" {
  description = "The name of the GitHub repository where the source code for the app is stored"
}

variable "github_team" {
  description = "The name of the GitHub team that will be added as reviewers to the repository"
}

variable "github_owner" {
  description = "The GitHub organization or individual user account containing the app's code repo. Used by the Github Terraform provider. See: https://user-guide.cloud-platform.service.justice.gov.uk/documentation/getting-started/ecr-setup.html#accessing-the-credentials"
  type        = string
  default     = "ministryofjustice"
}

variable "github_token" {
  type        = string
  description = "Required by the GitHub Terraform provider"
}

variable "source_template_repo" {
  description = "The source template repository used for this app."
  validation {
    condition     = contains(["hmpps-template-kotlin", "hmpps-template-typescript", "none"], var.source_template_repo)
    error_message = "Valid values for source_template_repo are: hmpps-template-kotlin or hmpps-template-typescript."
  }
}

variable "protected_branches_only" {
  description = "Whether to enabled deployments to this environment from protected branches only"
  type        = bool
  default     = true
}

variable "selected_branch_patterns" {
  description = "A list of patterns to match against branch names for deployment policies"
  type        = list(string)
  default     = []
}

variable "reviewer_teams" {
  description = "The GitHub team(s) that will be added as reviewers for deploying to this environment."
  type        = list(string)
  default     = []
}

variable "prevent_self_review" {
  description = "Whether to prevent self-review of deployments to this environment"
  type        = bool
  default     = false
}

variable "force_rotate_token" {
  description = "Boolean to force rotation of the service account token. Defaults to false."
  type        = bool
  default     = false
}

variable "custom_token_rotation_date" {
  description = "Custom value for serviceaccount_token_rotated_date. Defaults to empty string."
  type        = string
  default     = ""
}