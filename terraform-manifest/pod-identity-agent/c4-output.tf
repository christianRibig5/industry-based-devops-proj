output "pod_identity_agent_name" {
  value = aws_eks_addon.pod_identity_agent.addon_name
}

output "pod_identity_agent_version" {
  value = aws_eks_addon.pod_identity_agent.addon_version
}

output "pod_identity_agent_status" {
  value = aws_eks_addon.pod_identity_agent.status
}
