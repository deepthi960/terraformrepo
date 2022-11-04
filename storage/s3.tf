#Create S3 bucket
resource "aws_s3_bucket" "s3" {
    bucket                                              =   "${var.s3-bucket-name}"
    acl                                                 =   "${var.acl_value}"
    tags                                                =   {
      Name                                              =   "${var.eks_cluster_name}_worker_nodes_sg"
      "kubernetes.io/cluster/${var.eks_cluster_name}"   =   "${var.eks_cluster_name}"
      Environment                                       =   "${var.environment}"
  }
}