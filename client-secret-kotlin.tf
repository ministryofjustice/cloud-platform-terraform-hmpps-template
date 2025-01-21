# Create a secret with a blank value that is not managed by terraform,
# this will enabled the application to startup.
# Note: the hmpps-auth team will update this secret with the correct values
resource "kubernetes_secret" "kotlin_client_creds" {
  count = var.source_template_repo == "hmpps-template-kotlin" ? 1 : 0
  metadata {
    name      = "${var.application}-client-creds"
    namespace = var.namespace
    annotations = {
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
  data = {
    # Initial value for the client credentials
    API_CLIENT_ID     = "example value"
    API_CLIENT_SECRET = "example value"
  }
  lifecycle {
    ignore_changes = [data]
  }
}
