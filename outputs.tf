output "application" {
  description = "The name of the application (can be used in dependent modules/resources.)"
  value       = var.application
}

output "envoy_proxy_env_secret_name" {
  description = "The name of the Kubernetes secret containing Envoy proxy env vars"
  value       = var.enable_egress_controls ? kubernetes_secret.envoy_https_proxy_env[0].metadata[0].name : null
}