# Security group for control plane
resource "aws_security_group" "control_plane_sg" {
  name                                      = "${var.eks_cluster_name}_control_plane_sg"
  description                               = "CONTROL_PLANE Security Group"
  vpc_id                                    = aws_vpc.vpc.id

  tags                                                  = {
    Name                                                = "${var.eks_cluster_name}_control_plane_sg"
    "kubernetes.io/cluster/${var.eks_cluster_name}"     = "${var.eks_cluster_name}"
    Environment                                         = "${var.environment}"
  }
}

# Security group traffic rules
## Ingress rule
resource "aws_security_group_rule" "cca-canary-control_plane_inbound" {
  security_group_id                         = aws_security_group.control_plane_sg.id
  type                                      = "ingress"
  from_port                                 = 0
  to_port                                   = 65535
  protocol                                  = "tcp"
  cidr_blocks                               = flatten([var.private_subnet_cidr_blocks, var.public_subnet_cidr_blocks])
}

## Egress rule
resource "aws_security_group_rule" "cca-canary-control_plane_outbound" {
  security_group_id                         = aws_security_group.control_plane_sg.id
  type                                      = "egress"
  from_port                                 = 0
  to_port                                   = 65535
  protocol                                  = "-1"
  cidr_blocks                               = ["0.0.0.0/0"]
}