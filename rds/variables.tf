variable "region" {}
variable "eks_cluster_name" {}
variable "environment" {}
variable "project_name" {}
variable "engine_type" {}
variable "engine_version" {}
variable "multi_az" {}
variable "database_identifier" {}
variable "database_username" {}
variable "database_password" {}
variable "instance_type" {}
variable "storage_type" {}
#A minimum of 100 GiB allocated storage is required. if we use io1
variable "allocated_storage" {}
#The storage type gp2 does not support iops. enable only when using io1 storage type
variable "provisioned_iops" {}
#variable "enable_storage_autoscaling" {}
variable "max_allocated_storage" {}
variable "storage_encrypted" {}
variable "db_subnet_group" {}
variable "public_access" {}
variable "db_security_group" {}
variable "port_number" {}
variable "database_name" {}
variable "parameter_group_name" {}
#variable "snapshot_identifier" {}
variable "backup_retention_period" {}
variable "backup_window" {}
variable "final_snapshot_identifier" {}
variable "skip_final_snapshot" {}
variable "copy_tags_to_snapshot" {}
variable "performance_insights_enabled" {}
variable "performance_insights_retention_period" {}
variable "enabled_cloudwatch_logs_exports" {}
variable "monitoring_interval" {}
variable "auto_minor_version_upgrade" {}
variable "maintenance_window" {}
variable "deletion_protection" {}
variable "enable_db_security_group" {}
variable "vpc_id" {
  type        = string
  description = "ID of VPC meant to house database"
}