resource "aws_iam_role" "pod_role" {
  for_each = var.pod_identities

  name               = "${var.cluster_name}-${each.value.service_account_name}-role"
  assume_role_policy = var.trust_policy_json

  tags = merge(var.tags, {
    Name        = "${var.cluster_name}-${each.value.service_account_name}-role"
    Namespace   = each.value.namespace
    Service     = each.key
    Environment = var.environment_name
  })
}

resource "aws_iam_policy" "pod_policy" {
  for_each = var.managed_policy_arn == null ? var.pod_identities : {}

  name   = "${var.cluster_name}-${each.value.service_account_name}-policy"
  policy = var.permission_policy_json

  tags = merge(var.tags, {
    Name        = "${var.cluster_name}-${each.value.service_account_name}-policy"
    Namespace   = each.value.namespace
    Service     = each.key
    Environment = var.environment_name
  })
}

resource "aws_iam_role_policy_attachment" "pod_policy_attach" {
  for_each = var.pod_identities

  role = aws_iam_role.pod_role[each.key].name

  policy_arn = var.managed_policy_arn != null ? var.managed_policy_arn : aws_iam_policy.pod_policy[each.key].arn
}
