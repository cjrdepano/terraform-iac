# KMS Key for RDS Encryption
resource "aws_kms_key" "db_kms_key" {
  description         = "KMS key for RDS encryption"
  enable_key_rotation = true

  tags = {
    Name = "db-kms-key"
  }
}

output "kms_key_id" {
  value = aws_kms_key.db_kms_key.id
}

# Secrets Manager Secret for Database Credentials
resource "aws_secretsmanager_secret" "db_credentials" {
  name        = "cdp-<env>-<project>-credentials-aurora-db"
  description = "Database credentials for Aurora RDS instance"

  tags = {
    Name = "db-credentials"
  }
}

resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = "username"
    password = "username"
  })
}
