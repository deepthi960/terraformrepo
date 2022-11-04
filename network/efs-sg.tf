resource "aws_security_group" "efs_sg" {
   name = "${var.eks_cluster_name}_efs-sg"
   description= "Allow inbound efs traffic from EKS Cluster"
   vpc_id = aws_vpc.vpc.id

    tags                                                = {
      Name                                              = "${var.eks_cluster_name}_efs_sg"
      "kubernetes.io/cluster/${var.eks_cluster_name}"   = "${var.eks_cluster_name}"
      Environment                                       = "${var.environment}"
    }
}
## Ingress rule
resource "aws_security_group_rule" "efs_rule1" {
  description                                           = "Allow nodes to Access EFS"
  security_group_id                                     = aws_security_group.efs_sg.id
  type                                                  = "ingress"
  from_port                                             = 2049
  to_port                                               = 2049
  protocol                                              = "tcp"
  cidr_blocks                                           = flatten([var.private_subnet_cidr_blocks, var.public_subnet_cidr_blocks])
}

## Egress rule
resource "aws_security_group_rule" "efs_rule2" {
  security_group_id                 = aws_security_group.efs_sg.id
  type                              = "egress"
  from_port                         = 0
  to_port                           = 0
  protocol                          = "-1"
  cidr_blocks                       = ["0.0.0.0/0"]
}