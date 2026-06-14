
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
  description = "Environment name used in resource names and tags"
  type        = string
  default     = "dev"
}

variable "policy_json" {
  type        = string
  description = "IAM trust policy for pod identity roleß"
}

variable "tags" {
  description = "Global tags to apply to all resources"
  type        = map(string)
  default     = {}
}
