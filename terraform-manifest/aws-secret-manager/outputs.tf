output "catalog_db_secret_arn" {
  description = "ARN of the Catalog DB secret"
  value       = aws_secretsmanager_secret.catalog_db_secret.arn
}

output "catalog_db_secret_name" {
  description = "Name of the Catalog DB secret"
  value       = aws_secretsmanager_secret.catalog_db_secret.name
}
