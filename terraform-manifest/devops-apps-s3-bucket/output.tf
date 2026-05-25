output "s3_bucket_name" {
  value = aws_s3_bucket.devops_bucket_r5.bucket
}
output "s3_bucket_id" {
  value = aws_s3_bucket.devops_bucket_r5.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.devops_bucket_r5.arn
}
