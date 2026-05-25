
resource "aws_eks_pod_identity_association" "app_pia" {
  cluster_name    = data.terraform_remote_state.eks.outputs.eks_cluster_name
  namespace       = var.namespace
  service_account = var.service_account_name
  role_arn        = aws_iam_role.pod_role.arn

  depends_on = [
    kubernetes_service_account.app_sa,
    aws_iam_role_policy_attachment.attach_s3_policy
  ]
}
