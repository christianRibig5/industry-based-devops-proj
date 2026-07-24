variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "tag_mutability" {
  description = "Whether existing tags may be overwritten"
  type        = string
  default     = "IMMUTABLE"

  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.tag_mutability)
    error_message = "tag_mutability must be MUTABLE or IMMUTABLE."
  }
}

variable "scan_on_push" {
  description = "Enable basic image scanning when artifacts are pushed"
  type        = bool
  default     = false
}

variable "keep_versions" {
  description = "Number of artifact versions to retain"
  type        = number
  default     = 20
}

variable "force_delete" {
  description = "Allow Terraform to delete a repository containing artifacts"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to the repository"
  type        = map(string)
  default     = {}
}
