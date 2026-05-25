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
  name               = "${data.terraform_remote_state.eks.outputs.eks_cluster_name}-${var.service_account_name}-role"
  assume_role_policy = data.aws_iam_policy_document.pod_identity_trust.json

  tags = var.tags
}

resource "aws_iam_policy" "s3_policy" {
  name = "${data.terraform_remote_state.eks.outputs.eks_cluster_name}-${var.service_account_name}-s3-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = data.terraform_remote_state.app_bucket.outputs.s3_bucket_arn
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "${data.terraform_remote_state.app_bucket.outputs.s3_bucket_arn}/*"
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  role       = aws_iam_role.pod_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}
