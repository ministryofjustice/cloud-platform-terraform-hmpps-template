data "aws_ssm_parameter" "application_insights_key" {
  name = "/application_insights/key-${var.application_insights_instance}"
}

data "aws_ssm_parameter" "application_insights_id" {
  name = "/application_insights/application-id-${var.application_insights_instance}"
}

resource "kubernetes_secret" "application-insights" {
  count = contains(["hmpps-template-kotlin", "hmpps-template-typescript"], var.source_template_repo) ? 1 : 0
  metadata {
    name      = "${var.application}-application-insights"
    namespace = var.namespace
    annotations = {
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
  data = {
    APPINSIGHTS_INSTRUMENTATIONKEY        = data.aws_ssm_parameter.application_insights_key.value
    APPLICATIONINSIGHTS_CONNECTION_STRING = "InstrumentationKey=${data.aws_ssm_parameter.application_insights_key.value};IngestionEndpoint=https://northeurope-0.in.applicationinsights.azure.com/;LiveEndpoint=https://northeurope.livediagnostics.monitor.azure.com/;ApplicationId=${data.aws_ssm_parameter.application_insights_id.value}"
  }
}
