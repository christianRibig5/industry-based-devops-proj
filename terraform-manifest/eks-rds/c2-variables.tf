variable "aws_region" {
  type    = string
  default = "ca-central-1"
}

variable "awscli_user_profile" {
  description = "AWS Profile Owner running the resources"
  type        = string
  default     = "dev-admin"
}

variable "mysql_engine_version" {
  type    = string
  default = "8.0"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "max_allocated_storage" {
  type    = number
  default = 100
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
  }
}

