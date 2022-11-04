##### Globale Variables #####################
variable "region" {}
variable "project_name" {}
variable "eks_cluster_name" {}
variable "eks_cluster_version" {}
variable "environment" {}
variable "availability_zones" {}
##### Network Variables #####################
variable "vpc_cidr_block" {}
variable "private_subnet_cidr_blocks" {}
variable "private_subnet_tag_name" {}
variable "public_subnet_cidr_blocks" {}
variable "public_subnet_tag_name" {}
variable "db_subnet_cidr_blocks" {}
variable "db_subnet_tag_name" {}
variable "public_rt_tag_name" {}
variable "db_subnet_group_name" {}
##### EKS Configuration Values ###################################
#variable "node_group_name" {}
variable "endpoint_private_access" {}
variable "endpoint_public_access" {}
variable "eks_cluster_subnet_ids" {}
variable "public_subnet_ids" {}
variable "private_subnet_ids" {}
variable "general_ami_type" {}
variable "cpu_ami_type" {}
variable "asterisk_ami_type" {}
variable "disk_size" {}
variable "general_instance_types" {}
variable "cpu_instance_types" {}
variable "asterisk_instance_types" {}
variable "cpu_desired_size" {}
variable "cpu_max_size" {}
variable "cpu_min_size" {}
variable "general_desired_size" {}
variable "general_max_size" {}
variable "general_min_size" {}
variable "asterisk_desired_size" {}
variable "asterisk_max_size" {}
variable "asterisk_min_size" {}
variable "release_version" {}
variable "capacity_type" {}
variable "force_update_version" {}
##### EKS Configuration End ##############################################
##### RDS Configuration Values ###############
variable "engine_type" {}
variable "engine_version" {}
variable "multi_az" {}
variable "database_identifier" {}
variable "database_username" {}
variable "database_password" {}
variable "instance_type" {}
variable "storage_type" {}
variable "allocated_storage" {}
variable "provisioned_iops" {}
#variable "enable_storage_autoscaling" {}
variable "max_allocated_storage" {}
variable "storage_encrypted" {}
variable "public_access" {}
variable "port_number" {}
variable "database_name" {}
variable "parameter_group_name" {}
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
##### Storage Configuration ####################################
variable "acl_value" {}
variable "s3-bucket-name" {}
variable "efs_performance_mode" {}
#variable "efs_storage_class" {}
variable "efs_throughput_mode" {}
variable "efs_encrypted" {}
#variable "efs_automatic_backups" {}
variable "creation_token" {}


