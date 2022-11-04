##### RDS: IAM Role and Policy Creation#############################################################
data "aws_iam_policy_document" "enhanced_monitoring" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "rds-db_enhanced_monitoring" {
  name               = "rds-${var.eks_cluster_name}-EnhancedMonitoringRole"
  assume_role_policy = data.aws_iam_policy_document.enhanced_monitoring.json
}

resource "aws_iam_role_policy_attachment" "enhanced_monitoring" {
  role       = aws_iam_role.rds-db_enhanced_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_db_parameter_group" "postgres-db" {
  name = "eks-cluster-pg-db"
  family = "postgres14"
}
##### RDS Database Creation ###################################################################################################################
resource "aws_db_instance"  "rds"    {
  engine                                              = "${var.engine_type}"
  engine_version                                      = "${var.engine_version}"
  multi_az                                            = "${var.multi_az}"
  identifier                                          = "${var.database_identifier}"
  username                                            = "${var.database_username}"
  password                                            = "${var.database_password}"
  instance_class                                      = "${var.instance_type}"  
  storage_type                                        = "${var.storage_type}"
  allocated_storage                                   = "${var.allocated_storage}"
  iops                                                = "${var.provisioned_iops}"
#storage_autoscaling                                 = "${var.enable_storage_autoscaling}"
  max_allocated_storage                               = "${var.max_allocated_storage}"
  storage_encrypted                                   = "${var.storage_encrypted}"
  db_subnet_group_name                                = "${var.eks_cluster_name}_db_subnet_group"
  publicly_accessible                                 = "${var.public_access}"
  vpc_security_group_ids                              = ["${var.db_security_group}"]
  port                                                = "${var.port_number}"
  db_name                                             = "${var.database_name}"
  parameter_group_name                                = "${var.parameter_group_name}"
  #snapshot_identifier                                = "${var.snapshot_identifier}"
  backup_retention_period                             = "${var.backup_retention_period}"
  backup_window                                       = "${var.backup_window}"
  final_snapshot_identifier                           = "${var.final_snapshot_identifier}"
  skip_final_snapshot                                 = "${var.skip_final_snapshot}"
  copy_tags_to_snapshot                               = "${var.copy_tags_to_snapshot}"
  performance_insights_enabled                        = "${var.performance_insights_enabled}"
  performance_insights_retention_period               = "${var.performance_insights_retention_period}"
  enabled_cloudwatch_logs_exports                     = "${var.enabled_cloudwatch_logs_exports}" 
  monitoring_interval                                 = "${var.monitoring_interval}"
  monitoring_role_arn                                 = "${var.monitoring_interval}" > 0 ? aws_iam_role.rds-db_enhanced_monitoring.arn : ""
  auto_minor_version_upgrade                          = "${var.auto_minor_version_upgrade}"
  maintenance_window                                  = "${var.maintenance_window}"
  deletion_protection                                 = "${var.deletion_protection}"
    tags                                              = {
      Name                                              = "${var.eks_cluster_name}_db"
      "kubernetes.io/cluster/${var.eks_cluster_name}"   = "${var.eks_cluster_name}"
      Environment                                       = "${var.environment}"
      project                                           = "${var.project_name}"
  }
}
##### RDS Database Creation ###################################################################################################################