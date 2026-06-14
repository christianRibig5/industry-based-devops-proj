data "aws_iam_policy_document" "pod_identity_trust" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_iam_role" "pod_role" {
  for_each = var.pod_identities

  name = "${var.cluster_name}-${each.value.service_account_name}-role"

  assume_role_policy = data.aws_iam_policy_document.pod_identity_trust.json

  tags = merge(var.tags, {
    Name        = "${var.cluster_name}-${each.value.service_account_name}-role"
    Namespace   = each.value.namespace
    Service     = each.key
    Environment = var.environment_name
  })
}

resource "aws_iam_policy" "pod_policy" {
  for_each = var.pod_identities

  name = "${var.cluster_name}-${each.value.service_account_name}-policy"

  policy = var.policy_json

  tags = merge(var.tags, {
    Name        = "${var.cluster_name}-${each.value.service_account_name}-policy"
    Namespace   = each.value.namespace
    Service     = each.key
    Environment = var.environment_name
  })
}

resource "aws_iam_role_policy_attachment" "pod_policy_attach" {
  for_each = var.pod_identities

  role       = aws_iam_role.pod_role[each.key].name
  policy_arn = aws_iam_policy.pod_policy[each.key].arn
}
