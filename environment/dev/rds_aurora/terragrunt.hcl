terraform {
  source = "../../../modules//rds_aurora"
}

include {
  path = find_in_parent_folders()
}

locals {
  db = yamldecode(file("${find_in_parent_folders("vars_rds_aurora.yaml")}"))
}

inputs = {
  cluster_identifier        = local.db.cluster_identifier
  engine_version            = local.db.engine_version
  instance_class            = local.db.instance_class
  instance_count            = local.db.instance_count
  db_subnet_group_name      = local.db.db_subnet_group_name
  vpc_security_group_ids    = local.db.vpc_security_group_ids
  publicly_accessible       = local.db.publicly_accessible
  kms_key_id                = local.db.kms_key_id
  multi_az                  = local.db.multi_az
  tags                      = local.db.tags
  backup_retention_period   = local.db.backup_retention_period
  preferred_backup_window   = local.db.preferred_backup_window
  deletion_protection       = local.db.deletion_protection
  final_snapshot_identifier = local.db.final_snapshot_identifier
  copy_tags_to_snapshot     = local.db.copy_tags_to_snapshot
}
