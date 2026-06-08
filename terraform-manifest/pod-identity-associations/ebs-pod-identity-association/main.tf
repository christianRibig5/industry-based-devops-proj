module "catalog_pod_identity" {
  source = "../modules"

  cluster_name = data.terraform_remote_state.eks.outputs.eks_cluster_name

  pod_identities = {
    ebs-csi-controller = {
      namespace            = "kube-system"
      service_account_name = "ebs-csi-controller-sa"
    }
  }

  environment_name = var.environment_name
  tags             = var.tags
}
