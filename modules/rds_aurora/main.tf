# Fetch secrets from AWS Secrets Manager
data "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
}

# RDS Cluster Configuration
resource "aws_rds_cluster" "aurora_mysql" {
  cluster_identifier      = var.cluster_identifier
  engine                  = "aurora-mysql"
  engine_version          = var.engine_version
  master_username         = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string).username
  master_password         = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string).password
  db_subnet_group_name    = var.db_subnet_group_name
  vpc_security_group_ids  = var.vpc_security_group_ids
  tags                    = var.tags
  storage_encrypted       = true
  kms_key_id              = var.kms_key_id
  backup_retention_period = var.backup_retention_period
  preferred_backup_window = var.preferred_backup_window
  deletion_protection     = var.deletion_protection
  copy_tags_to_snapshot   = true

  lifecycle {
    create_before_destroy = true
  }

  skip_final_snapshot       = false
  final_snapshot_identifier = var.final_snapshot_identifier
}

resource "aws_rds_cluster_instance" "aurora_mysql_instance" {
  count                = var.instance_count
  identifier           = "${var.cluster_identifier}-${count.index + 1}"
  cluster_identifier   = aws_rds_cluster.aurora_mysql.id
  instance_class       = var.instance_class
  engine               = "aurora-mysql"
  engine_version       = var.engine_version
  publicly_accessible  = var.publicly_accessible
  db_subnet_group_name = var.db_subnet_group_name
  tags                 = var.tags
}
