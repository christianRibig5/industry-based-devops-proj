resource "kubernetes_namespace" "namespace" {
  for_each = {
    for _, v in var.pod_identities : v.namespace => v
  }

  metadata {
    name = each.key
  }
}
