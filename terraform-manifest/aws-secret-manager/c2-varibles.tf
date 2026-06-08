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
  description = "Environment name used in resource names and tags"
  type        = string
  default     = "dev"
}
variable "database_name" {
  description = "Catalog database name"
  type        = string
  default     = "catalogdb"
}

variable "database_username" {
  description = "Catalog database username"
  type        = string
  default     = "mydbadmin"
}

variable "tags" {
  type = map(string)

  default = {
    Terraform = "true"
    Owner     = "Christian Onyeukwu"
  }
}
