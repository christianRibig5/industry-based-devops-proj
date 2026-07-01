
resource "kubernetes_service_account" "app_sa" {
  for_each = var.pod_identities

  metadata {
    name      = each.value.service_account_name
    namespace = each.value.namespace
  }

  depends_on = [
    kubernetes_namespace.namespace
  ]
}
