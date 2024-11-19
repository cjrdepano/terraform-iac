variable "cluster_identifier" {
  description = "The cluster identifier"
  type        = string
  default     = "cdp-prod-regrep-aurora-db"
}

variable "engine_version" {
  description = "The Aurora MySQL engine version"
  type        = string
  default     = "8.0.mysql_aurora.3.05.2"
}

variable "instance_class" {
  description = "The instance class for the Aurora MySQL instances"
  type        = string
  default     = "db.t4g.large"
}

variable "instance_count" {
  description = "Number of Aurora MySQL instances"
  type        = number
  default     = 2
}

variable "db_subnet_group_name" {
  description = "The DB subnet group name"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "A list of VPC security groups to associate with this cluster"
  type        = list(string)
}

variable "publicly_accessible" {
  description = "Whether the DB instance is publicly accessible"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "The KMS key ARN for encryption at rest"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

variable "backup_retention_period" {
  description = "The number of days to retain backups"
  type        = number
  default     = 35
}

variable "preferred_backup_window" {
  description = "The preferred backup window for the cluster"
  type        = string
  default     = "23:00-23:59"
}

variable "deletion_protection" {
  description = "Enable deletion protection for the RDS cluster"
  type        = bool
  default     = true
}

variable "final_snapshot_identifier" {
  description = "The final snapshot identifier before destroying the cluster"
  type        = string
  default     = "final-snapshot-aurora-cluster"
}
