
variable "pod_identities" {
  type = map(object({
    namespace            = string
    service_account_name = string
  }))
}

variable "cluster_name" {
  type = string
}

variable "environment_name" {
  type    = string
  default = "dev"
}

variable "trust_policy_json" {
  type        = string
  description = "IAM trust policy for pod identity role"
}

variable "permission_policy_json" {
  type        = string
  description = "Custom IAM permission policy JSON for app pod identity role"
  default     = null
}

variable "managed_policy_arn" {
  type        = string
  description = "AWS managed policy ARN, used when no custom permission policy JSON is needed"
  default     = null
}

variable "create_service_account" {
  type        = bool
  description = "Whether module should create Kubernetes service account"
  default     = true
}

variable "tags" {
  description = "Global tags to apply to all resources"
  type        = map(string)
  default     = {}
}
