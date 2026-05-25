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
  # Remote Backend
  backend "s3" {
    bucket       = "tfstate-dev-ca-central-1-mr67svo6"
    key          = "eks/pod-identity-association/dev/terraform.tfstate"
    region       = "ca-central-1" #variable cant be applied
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.awscli_user_profile
}
