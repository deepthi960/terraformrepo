#Configure AWS Provider
provider "aws"  {
    region                                      = var.region
    profile                                     = "terraform-user"
}

##### Create VPC #######################################################################
module "network" {
  source                                        = "./network"
  region                                        =   var.region
  project_name                                  =   var.project_name
  eks_cluster_name                              =   var.eks_cluster_name
  environment                                   =   var.environment 
  vpc_cidr_block                                =   var.vpc_cidr_block
  availability_zones                            =   var.availability_zones
  public_subnet_cidr_blocks                     =   var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks                    =   var.private_subnet_cidr_blocks
  db_subnet_cidr_blocks                         =   var.db_subnet_cidr_blocks
  public_subnet_tag_name                        =   var.public_subnet_tag_name
  private_subnet_tag_name                       =   var.private_subnet_tag_name
  db_subnet_tag_name                            =   var.db_subnet_tag_name
  public_rt_tag_name                            =   var.public_rt_tag_name
  db_subnet_group_name                          =   var.db_subnet_group_name
}
##### Create EKS Cluster ##############################################################
module "eks" {
  source                                        = "./eks"
  vpc_id                                        =   module.network.vpc_id
  project_name                                  =   var.project_name
  region                                        =   var.region
  environment                                   =   var.environment
  eks_cluster_name                              =   var.eks_cluster_name
  eks_cluster_version                           =   var.eks_cluster_version
#  node_group_name                               =   var.node_group_name
  endpoint_private_access                       =   var.endpoint_private_access
  endpoint_public_access                        =   var.endpoint_public_access
  availability_zones                            =   var.availability_zones
  eks_cluster_subnet_ids                        =   flatten([module.network.public_subnet_id, module.network.private_subnet_id])
  public_subnet_ids                             =   module.network.public_subnet_id
  private_subnet_ids                            =   module.network.private_subnet_id
  general_ami_type                              =   var.general_ami_type
  cpu_ami_type                                  =   var.cpu_ami_type
  asterisk_ami_type                             =   var.asterisk_ami_type
  disk_size                                     =   var.disk_size
  general_instance_types                        =   var.general_instance_types
  cpu_instance_types                            =   var.cpu_instance_types
  asterisk_instance_types                       =   var.asterisk_instance_types
  cpu_desired_size                              =   var.cpu_desired_size
  cpu_max_size                                  =   var.cpu_max_size
  cpu_min_size                                  =   var.cpu_min_size
  general_desired_size                          =   var.general_desired_size
  general_max_size                              =   var.general_max_size
  general_min_size                              =   var.general_min_size
  asterisk_desired_size                         =   var.asterisk_desired_size
  asterisk_max_size                             =   var.asterisk_max_size
  asterisk_min_size                             =   var.asterisk_min_size
  release_version                               =   var.release_version
  capacity_type                                 =   var.capacity_type
  force_update_version                          =   var.force_update_version
  eks_cluster_sg                                =   module.eks.eks_cluster_sg_id
  eks_nodes_sg                                  =   module.eks.eks_nodes_sg_id
}
##### Create Postgres RDS DB Instance
module "rds" {
  source                                        = "./rds"
  vpc_id                                        =   module.network.vpc_id
  region                                        =   var.region
  eks_cluster_name                              =   var.eks_cluster_name
  environment                                   =   var.environment
  project_name                                  =   var.project_name
  engine_type                                   =   var.engine_type
  engine_version                                =   var.engine_version
  multi_az                                      =   var.multi_az
  database_identifier                           =   var.database_identifier
  database_username                             =   var.database_username
  database_password                             =   var.database_password
  instance_type                                 =   var.instance_type
  storage_type                                  =   var.storage_type
  allocated_storage                             =   var.allocated_storage
  provisioned_iops                              =   var.provisioned_iops
  #enable_storage_autoscaling                    =   var.enable_storage_autoscaling
  max_allocated_storage                         =   var.max_allocated_storage
  storage_encrypted                             =   var.storage_encrypted
  db_subnet_group                               =   module.network.db_subnet_group_id
  public_access                                 =   var.public_access
  db_security_group                             =   module.network.db_sg_id
  port_number                                   =   var.port_number
  database_name                                 =   var.database_name
  parameter_group_name                          =   var.parameter_group_name
  #snapshot_identifier                           =   var.snapshot_identifier
  backup_retention_period                       =   var.backup_retention_period
  backup_window                                 =   var.backup_window
  final_snapshot_identifier                     =   var.final_snapshot_identifier
  skip_final_snapshot                           =   var.skip_final_snapshot
  copy_tags_to_snapshot                         =   var.copy_tags_to_snapshot
  performance_insights_enabled                  =   var.performance_insights_enabled
  performance_insights_retention_period         =   var.performance_insights_retention_period
  enabled_cloudwatch_logs_exports               =   var.enabled_cloudwatch_logs_exports
  monitoring_interval                           =   var.monitoring_interval
  auto_minor_version_upgrade                    =   var.auto_minor_version_upgrade
  maintenance_window                            =   var.maintenance_window
  deletion_protection                           =   var.deletion_protection
  enable_db_security_group                      =   var.enable_db_security_group
}
##### Create Storage - S3 & EFS ############################################################
module "storage" {
  source                                        = "./storage"
  region                                        =   var.region
  eks_cluster_name                              =   var.eks_cluster_name
  environment                                   =   var.environment
  project_name                                  =   var.project_name
  acl_value                                     =   var.acl_value
  s3-bucket-name                                =   var.s3-bucket-name
  creation_token                                =   var.creation_token
  efs_performance_mode                          =   var.efs_performance_mode
#  efs_storage_class                             =   var.efs_storage_class
  efs_throughput_mode                           =   var.efs_throughput_mode
  efs_encrypted                                 =   var.efs_encrypted
#  efs_automatic_backups                        =   var.efs_automatic_backups
  private_subnet_id                             =   flatten([module.network.private_subnet_id])
  efs_sg_id                                     =   module.network.efs_sg_id
#  availability_zones                            =   var.availability_zones
  vpc_id                                        =   module.network.vpc_id
}
