variable "aws_region" {
  description = "AWS Region for deployment"
  type        = string
  default     = "ca-central-1"
}

variable "awscli_user_profile" {
  description = "AWS Profile Owner running the resources"
  type        = string
  default     = "dev-admin"
}
variable "environment_name" {
  type    = string
  default = "dev"
}

variable "tags" {
  type = map(string)

  default = {
    Terraform = "true"
    Owner     = "Christian Onyeukwu"
    Project   = "Pod Identity Association"
    Purpose   = "ebs pod identity"
  }
}
