########### Security Group for DB #############################################################################################
resource "aws_security_group" "db_sg" {
  name                                                = "${var.eks_cluster_name}_db_sg"
  vpc_id                                              = aws_vpc.vpc.id
  description                                         = "Security group for prod_eks_01 DB"

    tags                                                = {
      Name                                              = "${var.eks_cluster_name}_db_sg"
      "kubernetes.io/cluster/${var.eks_cluster_name}"   = "${var.eks_cluster_name}"
      Environment                                       = "${var.environment}"
    }
}
## Ingress rule1
resource "aws_security_group_rule" "db_sg_r1" {
  description                                         = "Allow VPC to communicate with the DB"
  from_port                                           = 5432
  protocol                                            = "tcp"
  security_group_id                                   = aws_security_group.db_sg.id
  cidr_blocks                                         = [var.vpc_cidr_block]
  to_port                                             = 5432
  type                                                = "ingress"
}