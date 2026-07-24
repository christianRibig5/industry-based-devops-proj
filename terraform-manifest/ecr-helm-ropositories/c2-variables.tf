variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ca-central-1"
}

variable "awscli_user_profile" {
  description = "AWS Profile Owner running the resources"
  type        = string
  default     = "dev-admin"
}

variable "environment_name" {
  description = "Environment name used in resource names and tags"
  type        = string
  default     = "dev"
}

variable "helm_repositories" {
  description = "Helm chart ECR repositories to create"

  type = map(object({
    repository_name = string
    keep_versions   = optional(number, 20)
    tag_mutability  = optional(string, "IMMUTABLE")
    scan_on_push    = optional(bool, false)
    force_delete    = optional(bool, false)
  }))
}

variable "common_tags" {
  description = "Tags applied to every repository"
  type        = map(string)

  default = {
    Project     = "RetailStore"
    Environment = "Lab"
    ManagedBy   = "Terraform"
  }
}
