variable "aws_region" {
  description = "AWS region for Lambda deployment"
  type        = string
  default     = "ca-central-1"
}

variable "alert_email" {
  description = "Email address to receive AWS cost alerts"
  type        = string
}

variable "monthly_cost_threshold" {
  description = "Monthly AWS cost threshold"
  type        = number
  default     = 20
}
variable "environment_name" {
  description = "Environment name used in resource names and tags"
  type        = string
  default     = "dev"
}
variable "awscli_user_profile" {
  description = "AWS Profile Owner running the resources"
  type        = string
  default     = "dev-admin"
}
