
resource "kubernetes_service_account" "app_sa" {
  metadata {
    name      = var.service_account_name
    namespace = var.namespace
  }
}
