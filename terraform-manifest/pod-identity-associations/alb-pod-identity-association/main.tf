module "alb_pod_identity" {
  source = "../modules"

  cluster_name = data.terraform_remote_state.eks.outputs.eks_cluster_name

  create_service_account = true

  trust_policy_json      = file("${path.module}/../../iam-policy-json-files/aws-load-balancer-controller-trust-policy.json")
  permission_policy_json = file("${path.module}/../../iam-policy-json-files/aws-load-balancer-controller-permission-policy.json")

  pod_identities = {
    aws_load_balancer_controller = {
      namespace            = "kube-system"
      service_account_name = "aws-load-balancer-controller-sa"
    }
  }

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
    Service     = "aws-load-balancer-controller"
  }
}
