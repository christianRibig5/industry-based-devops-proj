resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name                = data.terraform_remote_state.eks.outputs.name
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = var.addon_version
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  tags = var.tags
}
