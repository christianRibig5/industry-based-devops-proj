module "ui_namespace" {
  source    = "../../pod-identity-associations/modules/namespace"
  namespace = var.namespace
}
