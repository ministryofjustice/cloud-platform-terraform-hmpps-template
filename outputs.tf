output "application" {
  description = "The name of the application (can be used in dependent modules/resources.)"
  value       = var.application
}

output "ecr_repo_url" {
  description = "ECR repository URL (null if enable_ecr is false)"
  value       = var.enable_ecr ? module.ecr[0].repo_url : null
}

output "ecr_irsa_policy_arn" {
  description = "ECR IRSA policy ARN (null if enable_ecr is false or ecr_enable_irsa is false)"
  value       = var.enable_ecr ? module.ecr[0].irsa_policy_arn : null
}