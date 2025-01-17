#################
# Configuration #
#################

# Add module-specific variables here

########
# Tags #
########
variable "business_unit" {
  description = "Area of the MOJ responsible for the service"
  type        = string
}

variable "application" {
  description = "Application name"
  type        = string
}

variable "is_production" {
  description = "Whether this is used for production or not"
  type        = string
}

variable "team_name" {
  description = "Team name"
  type        = string
}

variable "namespace" {
  description = "Namespace name"
  type        = string
}

variable "environment_name" {
  description = "Environment name"
  type        = string
}

variable "infrastructure_support" {
  description = "The team responsible for managing the infrastructure. Should be of the form <team-name> (<team-email>)"
  type        = string
}

# application_insights_instance should be set to one of:
# "dev" (appears as t3 in azure portal) or "preprod" or "prod".
# This determines which instance of application insights metrics and logs are sent to.
variable "application_insights_instance" {
  description = "Determines which instrumentation key to use for Application Insights."
  type        = string
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

variable "serviceaccount_name" {
  description = "The name of the service account to be created"
  default     = "github-actions-sa"
}

variable "source_template_repo" {
  description = "The source template repository used for this app."
  validation {
    condition     = contains(["hmpps-template-kotlin", "hmpps-template-typescript"], var.source_template_repo)
    error_message = "Valid values for source_template_repo are: hmpps-template-kotlin or hmpps-template-typescript."
  }
}