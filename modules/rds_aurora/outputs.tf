output "cluster_endpoint" {
  description = "The endpoint of the Aurora MySQL cluster"
  value       = aws_rds_cluster.aurora_mysql.endpoint
}

output "cluster_reader_endpoint" {
  description = "The reader endpoint of the Aurora MySQL cluster"
  value       = aws_rds_cluster.aurora_mysql.reader_endpoint
}

output "instance_endpoints" {
  description = "The endpoints of the Aurora MySQL instances"
  value       = aws_rds_cluster_instance.aurora_mysql_instance[*].endpoint
}

output "secret_arn" {
  description = "The ARN of the Secrets Manager secret containing the database credentials"
  value       = aws_secretsmanager_secret.db_credentials.arn
}
