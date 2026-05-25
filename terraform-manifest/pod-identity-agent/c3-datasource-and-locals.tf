data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = "tfstate-dev-ca-central-1-mr67svo6"
    key    = "eks/dev/terraform.tfstate"
    region = "ca-central-1"
  }
}
