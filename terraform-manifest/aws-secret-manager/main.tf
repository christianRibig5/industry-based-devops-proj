# ==========================================================
# AWS Secrets Manager Secret for Catalog MySQL Credentials
# Stores reusable database username, password, database name,
# can be used by RDS, EC2, Docker, Kubernetes or Autora
# ==========================================================

resource "aws_secretsmanager_secret" "catalog_db_secret" {
  name        = "${var.environment_name}/mysql/secret"
  description = "Catalog MySQL RDS credentials for ${var.environment_name} environment"

  recovery_window_in_days = 0

  tags = var.tags
}
resource "random_password" "catalog_db_password" {
  length  = 20
  special = true
}

resource "aws_secretsmanager_secret_version" "catalog_db_secret_version" {
  secret_id = aws_secretsmanager_secret.catalog_db_secret.id

  secret_string = jsonencode({
    username = var.database_username
    password = random_password.catalog_db_password.result
    database = var.database_name
  })
}
