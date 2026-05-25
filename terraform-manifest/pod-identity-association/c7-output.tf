output "pod_identity_role_arn" {
  value = aws_iam_role.pod_role.arn
}

output "pod_identity_role_name" {
  value = aws_iam_role.pod_role.name
}

output "service_account_name" {
  value = kubernetes_service_account.app_sa.metadata[0].name
}

output "service_account_namespace" {
  value = kubernetes_service_account.app_sa.metadata[0].namespace
}

output "s3_policy_arn" {
  value = aws_iam_policy.s3_policy.arn
}

output "pod_identity_association_id" {
  value = aws_eks_pod_identity_association.app_pia.association_id
}
