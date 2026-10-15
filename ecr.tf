module "ecr" {
  count  = var.enable_ecr ? 1 : 0
  source = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=8.0.2"

  # Repository configuration
  repo_name = coalesce(var.ecr_repo_name, var.application)

  # OpenID Connect configuration
  oidc_providers      = ["github"]
  github_repositories = [var.github_repo]

  # Tags
  business_unit          = var.business_unit
  application            = var.application
  is_production          = var.is_production
  team_name              = var.team_name # also used as the repository name prefix
  namespace              = var.namespace # also used for creating a Kubernetes ConfigMap
  environment_name       = var.environment
  infrastructure_support = var.infrastructure_support
  deletion_protection    = var.ecr_deletion_protection
  github_actions_prefix  = var.ecr_github_actions_prefix
  enable_irsa            = var.ecr_enable_irsa
}

resource "github_actions_variable" "ecr_registry" {
  count         = var.enable_ecr ? 1 : 0
  repository    = var.github_repo
  variable_name = "CLOUD_PLATFORM_ECR_REGISTRY_URL"
  value         = split("/", module.ecr[0].repo_url)[0]
}
