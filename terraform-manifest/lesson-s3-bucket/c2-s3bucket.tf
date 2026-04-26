#random string block
resource "random_string" "appendix" {
  length  = 8
  special = false
  upper   = false
}

#s3 bucket resouce
resource "aws_s3_bucket" "demo_bucket_r5" {
  bucket = "devopsdemo-${random_string.appendix.result}"

  tags = {
    Name         = "DevOps demo bucket"
    Environment  = "Dev"
    owner        = "Christian Onyeukwu"
    Organization = "JALEX Solutions Inc"
  }
}
