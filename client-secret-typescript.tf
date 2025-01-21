# Create a secret with a blank value that is not managed by terraform,
# this will enabled the application to startup.
# Note: the hmpps-auth team will update this secret with the correct values
resource "kubernetes_secret" "client_creds" {
  count = var.source_template_repo == "hmpps-template-typescript" ? 1 : 0
  metadata {
    name      = "${var.application}-client-creds"
    namespace = var.namespace
    annotations = {
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
  data = {
    # Initial value for the client credentials
    CLIENT_CREDS_CLIENT_ID     = "example value"
    CLIENT_CREDS_CLIENT_SECRET = "example value"
  }
  lifecycle {
    ignore_changes = [data]
  }
}

resource "kubernetes_secret" "auth_code_secret" {
  count = var.source_template_repo == "hmpps-template-typescript" ? 1 : 0
  metadata {
    name      = "${var.application}-auth-code"
    namespace = var.namespace
    annotations = {
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
  data = {
    # Initial value for the client credentials
    AUTH_CODE_CLIENT_ID     = "example value"
    AUTH_CODE_CLIENT_SECRET = "example value"
  }
  lifecycle {
    ignore_changes = [data]
  }
}