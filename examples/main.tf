module "hmpps_template_typescript" {
  source = "../"
  # source = "github.com/ministryofjustice/cloud-platform-terraform-template?ref=version" # use the latest release
  github_repo                   = "hmpps-template-typescript"
  application                   = "hmpps-template-typescript"
  github_team                   = "hmpps-sre"
  environment                   = var.environment # Should match environment name used in helm values file e.g. values-dev.yaml
  reviewer_teams                = ["hmpps-dev-team-1", "hmpps-dev-team-2"]
  selected_branch_patterns      = ["main", "release/*", "feature/*"]
  is_production                 = var.is_production
  application_insights_instance = "dev" # Either "dev", "preprod" or "prod"
  source_template_repo          = "hmpps-template-typescript"
  github_token                  = var.github_token
  namespace                     = var.namespace
  kubernetes_cluster            = var.kubernetes_cluster
}

module "hmpps_template_kotlin" {
  source = "../"
  # source = "github.com/ministryofjustice/cloud-platform-terraform-template?ref=version" # use the latest release
  github_repo                   = "hmpps-template-kotlin"
  application                   = "hmpps-template-kotlin"
  github_team                   = "hmpps-sre"
  environment                   = var.environment # Should match environment name used in helm values file e.g. values-dev.yaml
  reviewer_teams                = ["hmpps-dev-team-1", "hmpps-dev-team-2"]
  selected_branch_patterns      = ["main", "release/*", "feature/*"]
  is_production                 = var.is_production
  application_insights_instance = "dev" # Either "dev", "preprod" or "prod"
  source_template_repo          = "hmpps-template-kotlin"
  github_token                  = var.github_token
  namespace                     = var.namespace
  kubernetes_cluster            = var.kubernetes_cluster
}
