# cloud-platform-terraform-template

[![Releases](https://img.shields.io/github/v/release/ministryofjustice/cloud-platform-terraform-template.svg)](https://github.com/ministryofjustice/cloud-platform-terraform-template/releases)

This Terraform module will create the basic resources needed for the successful deployment of HMPPS template applications, either hmpps-template-kotlin or hmpps-template-typescript.

It will setup the following required resources:
- Kubernetes service account for github actions deployments.
- Setup of github actions environments.
- Export the service account credentials to github actions environments.
- Automatically rotate service account credentials every week.
- Setup Azure Applications Insights instrumentation key, saved to a Kubernetes secret.
- Setup sessions secret (for typescript apps),saved to a Kubernetes secret.
- Setup empty client credentials for hmpps-auth integration, saved to a Kubernetes secret.

**NOTE**: this module does not setup other resources such as RDS/S3/ElastiCache/SQS/SNS - these need to be configured on a per need basis within the cloud-platform-environments repo.

It is recommended that the output variable _application_ of this module is used to create dependencies between this module and any dependent resources. e.g.

```hcl
application = module.hmpps_template_typescript.application
```

## Usage

```hcl
module "template" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-template?ref=version" # use the latest release

  # Configuration
  github_repo                   = "hmpps-template-typescript"
  application                   = "hmpps-template-typescript"
  github_team                   = "hmpps-sre"
  environment                   = var.environment # Should match names in helm files.
  application_insights_instance = "dev" # Either "dev", "preprod" or "prod"
  source_template_repo          = "hmpps-template-typescript"
  namespace                     = var.namespace
  github_token                  = var.github_token
  kubernetes_cluster            = var.kubernetes_cluster
  business_unit                 = var.business_unit
  application                   = var.application
  is_production                 = var.is_production
}
```

See the [examples/](examples/) folder for more information.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 5.39.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0.0 |
| <a name="provider_github"></a> [github](#provider\_github) | ~> 5.39.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.0.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.6.0 |
| <a name="provider_time"></a> [time](#provider\_time) | ~> 0.9.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_service_account"></a> [service\_account](#module\_service\_account) | github.com/ministryofjustice/cloud-platform-terraform-serviceaccount | 1.1.0 |

## Resources

| Name | Type |
|------|------|
| [github_actions_environment_variable.namespace_env_var](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_variable) | resource |
| [github_repository_environment.env](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_environment) | resource |
| [kubernetes_secret.application-insights](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.client_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.session_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [random_password.session_secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [time_rotating.weekly](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_ssm_parameter.application_insights_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [github_team.hmpps_dev_team](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/team) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input\_application) | Application name | `string` | n/a | yes |
| <a name="input_application_insights_instance"></a> [application\_insights\_instance](#input\_application\_insights\_instance) | Determines which instrumentation key to use for Application Insights. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name - must match environment names used in helm files. | `string` | n/a | yes |
| <a name="input_github_owner"></a> [github\_owner](#input\_github\_owner) | The GitHub organization or individual user account containing the app's code repo. Used by the Github Terraform provider. See: https://user-guide.cloud-platform.service.justice.gov.uk/documentation/getting-started/ecr-setup.html#accessing-the-credentials | `string` | `"ministryofjustice"` | no |
| <a name="input_github_repo"></a> [github\_repo](#input\_github\_repo) | The name of the GitHub repository where the source code for the app is stored | `any` | n/a | yes |
| <a name="input_github_team"></a> [github\_team](#input\_github\_team) | The name of the GitHub team that will be added as reviewers to the repository | `any` | n/a | yes |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | Required by the GitHub Terraform provider | `string` | n/a | yes |
| <a name="input_infrastructure_support"></a> [infrastructure\_support](#input\_infrastructure\_support) | The team responsible for managing the infrastructure. Should be of the form <team-name> (<team-email>) | `string` | n/a | yes |
| <a name="input_is_production"></a> [is\_production](#input\_is\_production) | Whether this is used for production or not | `string` | n/a | yes |
| <a name="input_kubernetes_cluster"></a> [kubernetes\_cluster](#input\_kubernetes\_cluster) | The name of the Kubernetes cluster | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace name | `string` | n/a | yes |
| <a name="input_serviceaccount_name"></a> [serviceaccount\_name](#input\_serviceaccount\_name) | The name of the service account to be created | `string` | `"github-actions-sa"` | no |
| <a name="input_source_template_repo"></a> [source\_template\_repo](#input\_source\_template\_repo) | The source template repository used for this app. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application"></a> [application](#output\_application) | The name of the application (can be used in dependent modules/resources.) |
<!-- END_TF_DOCS -->

## Tags

Some of the inputs for this module are tags. All infrastructure resources must be tagged to meet the MOJ Technical Guidance on [Documenting owners of infrastructure](https://technical-guidance.service.justice.gov.uk/documentation/standards/documenting-infrastructure-owners.html).

You should use your namespace variables to populate these. See the [Usage](#usage) section for more information.

## Reading Material

<!-- Add links to useful documentation -->

- [Cloud Platform user guide](https://user-guide.cloud-platform.service.justice.gov.uk/#cloud-platform-user-guide)
