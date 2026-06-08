

resource "aws_db_subnet_group" "catalog_rds_subnet_group" {
  name = "${var.environment_name}-catalog-rds-subnet-group"

  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids

  tags = var.tags
}

resource "aws_security_group" "catalog_rds_sg" {
  name        = "${var.environment_name}-catalog-rds-sg"
  description = "Allow MySQL from EKS cluster security group"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    description = "Allow MySQL from EKS Cluster security group"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"

    security_groups = [
      data.terraform_remote_state.eks.outputs.eks_cluster_security_group_id
    ]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_db_instance" "catalog_mysql" {
  identifier = "${var.environment_name}-catalog-mysql"

  engine         = "mysql"
  engine_version = var.mysql_engine_version
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = local.catalog_db_credentials.database
  username = local.catalog_db_credentials.username
  password = local.catalog_db_credentials.password

  db_subnet_group_name   = aws_db_subnet_group.catalog_rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.catalog_rds_sg.id]

  publicly_accessible = false
  multi_az            = false

  backup_retention_period = 7
  deletion_protection     = false
  skip_final_snapshot     = true

  tags = var.tags
}

