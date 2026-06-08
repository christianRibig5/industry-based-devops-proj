data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = "tfstate-dev-ca-central-1-mr67svo6"
    key    = "eks/dev/terraform.tfstate"
    region = "ca-central-1"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "tfstate-dev-ca-central-1-mr67svo6"
    key    = "vpc/dev/terraform.tfstate"
    region = "ca-central-1" #variable cant be applied
  }
}
data "terraform_remote_state" "secret" {
  backend = "s3"

  config = {
    bucket = "tfstate-dev-ca-central-1-mr67svo6"
    key    = "secret/aws-secret-manager/dev/terraform.tfstate"
    region = "ca-central-1" #variable cant be applied
  }
}
data "aws_secretsmanager_secret" "catalog_db_secret" {
  arn = data.terraform_remote_state.secret.outputs.catalog_db_secret_arn
}

data "aws_secretsmanager_secret_version" "catalog_db_secret_version" {
  secret_id = data.aws_secretsmanager_secret.catalog_db_secret.id
}

locals {
  catalog_db_credentials = jsondecode(
    data.aws_secretsmanager_secret_version.catalog_db_secret_version.secret_string
  )
}
