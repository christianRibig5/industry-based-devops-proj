module "catalog_pod_identity" {
  source = "../modules"

  cluster_name           = data.terraform_remote_state.eks.outputs.eks_cluster_name
  create_service_account = true

  pod_identities = {
    catalog = {
      namespace            = "catalog"
      service_account_name = "catalog-mysql-sa"
    }
  }
  trust_policy_json      = file("${path.module}/../../iam-policy-json-files/catalog-db-trust-policy.json")
  permission_policy_json = file("${path.module}/../../iam-policy-json-files/catalog-db-permission-policy.json")

  environment_name = var.environment_name
  tags             = var.tags
}
