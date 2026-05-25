#random string block
resource "random_string" "appendix" {
  length  = 8
  special = false
  upper   = false
}

#s3 bucket resouce
resource "aws_s3_bucket" "devops_bucket_r5" {
  bucket = "devopsapps-${random_string.appendix.result}"

  tags = {
    Name        = "DevOps app bucket"
    Environment = "Dev"
    owner       = "Christian Onyeukwu"
  }
}
