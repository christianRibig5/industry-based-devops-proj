module "helm_repositories" {
  source = "./modules"

  for_each = var.helm_repositories

  repository_name = each.value.repository_name
  keep_versions   = each.value.keep_versions
  tag_mutability  = each.value.tag_mutability
  scan_on_push    = each.value.scan_on_push
  force_delete    = each.value.force_delete

  tags = merge(
    var.common_tags,
    {
      Service     = each.key
      Environment = var.environment_name
    }
  )
}
