variable "aws_region" {
  description = "AWS Region for deployment"
  type        = string
  default     = "ca-central-1"
}

variable "awscli_user_profile" {
  description = "AWS Profile Owner running the resources"
  type        = string
  default     = "devops"
}
variable "cluster_name" {
  default = "your-existing-eks-cluster-name"
}

variable "namespace" {
  default = "default"
}

variable "service_account_name" {
  default = "s3-app-sa"
}

variable "bucket_name" {
  default = "your-real-application-s3-bucket-name"

}

variable "environment_name" {
  description = "Environment name used in resource names and tags"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Global tags to apply to all resources"
  type        = map(string)
  default = {
    Terraform = "true"
    Owner     = "Christian Onyeukwu"
    Project   = "Pod Identity Agent Project"
    Purpose   = ""
  }
}
