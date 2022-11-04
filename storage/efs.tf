data "aws_vpc" "main" {
  id = "${var.vpc_id}"
}

resource "aws_efs_file_system" "efs" {
    creation_token      =       "${var.creation_token}"
    performance_mode    =       "${var.efs_performance_mode}" 
#    storage_class       =       "${var.efs_storage_class}"
    throughput_mode     =       "${var.efs_throughput_mode}"
    encrypted           =       "${var.efs_encrypted}"
#    automatic_backups   =       "${var.efs_automatic_backups}"
    tags                                                =   {
      Name                                              =   "${var.eks_cluster_name}_efs"
      "kubernetes.io/cluster/${var.eks_cluster_name}"   =   "${var.eks_cluster_name}"
      Environment                                       =   "${var.environment}"
  }
}

resource "aws_efs_access_point" "efs" {
    file_system_id      =   "${aws_efs_file_system.efs.id}"
}

resource    "aws_efs_mount_target"  "efs_mount" {
    file_system_id      =   "${aws_efs_file_system.efs.id}"
   subnet_id           =   "flatten(var.private_subnet_id)"
 #   subnet_id           =   "${var.private_subnet_id}"
    security_groups     =   [var.efs_sg_id]
 }

