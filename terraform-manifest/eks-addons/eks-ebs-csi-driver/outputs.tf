output "addon_name" {
  value = aws_eks_addon.ebs_csi_driver.addon_name
}

output "addon_arn" {
  value = aws_eks_addon.ebs_csi_driver.arn
}
