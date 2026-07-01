module "ebs_pod_identity" {
  source = "../modules"

  cluster_name = data.terraform_remote_state.eks.outputs.eks_cluster_name

  create_service_account = false

  managed_policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"

  trust_policy_json = file("${path.module}/../../iam-policy-json-files/ebs-csi-driver-trust-policy.json")

  pod_identities = {
    ebs_csi = {
      namespace            = "kube-system"
      service_account_name = "ebs-csi-controller-sa"
    }
  }

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
    Service     = "ebs-csi"
  }
}
