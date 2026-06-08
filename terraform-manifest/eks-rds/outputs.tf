output "catalog_rds_endpoint" {
  value = aws_db_instance.catalog_mysql.address
}

output "catalog_rds_port" {
  value = aws_db_instance.catalog_mysql.port
}

output "catalog_rds_database_name" {
  value = aws_db_instance.catalog_mysql.db_name
}

output "catalog_rds_security_group_id" {
  value = aws_security_group.catalog_rds_sg.id
}
