resource "aws_eks_pod_identity_association" "app_pia" {
  cluster_name    = var.cluster_name
  namespace       = var.namespace
  service_account = var.service_account_name
  role_arn        = aws_iam_role.pod_role.arn

  depends_on = [
    aws_eks_addon.pod_identity_agent,
    kubernetes_service_account.app_sa,
    aws_iam_role_policy_attachment.attach_s3_policy
  ]
}
