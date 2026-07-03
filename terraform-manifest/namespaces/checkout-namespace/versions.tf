terraform {
  required_version = ">=1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2.30"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.awscli_user_profile
}
provider "kubernetes" {
  config_path = "~/.kube/config"
}

