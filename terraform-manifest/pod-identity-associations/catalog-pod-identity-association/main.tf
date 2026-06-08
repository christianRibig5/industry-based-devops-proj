module "catalog_pod_identity" {
  source = "../modules"

  cluster_name = data.terraform_remote_state.eks.outputs.eks_cluster_name

  pod_identities = {
    catalog = {
      namespace            = "catalog"
      service_account_name = "catalog-mysql-sa"
    }
  }

  environment_name = var.environment_name
  tags             = var.tags
}
