# Security group for public subnet resources
resource "aws_security_group" "public1_sg" {
  name                              =   "${var.eks_cluster_name}_public1_sg"
  vpc_id                            =   aws_vpc.vpc.id
  description                       =   "HTTP & HTTPS access from internet"
  tags                                                      = {
    Name                                                    = "${var.eks_cluster_name}_public1_sg"
    "kubernetes.io/cluster/${var.eks_cluster_name}"         =   "${var.eks_cluster_name}"
    Environment                                             =   "${var.environment}"
  }
}

# Security group traffic rules
## Ingress rule1
resource "aws_security_group_rule" "public1_https" {
  security_group_id                 = aws_security_group.public1_sg.id
  type                              = "ingress"
  from_port                         = 443
  to_port                           = 443
  protocol                          = "tcp"
  cidr_blocks                       = ["0.0.0.0/0"]
}
## Ingress rule2
resource "aws_security_group_rule" "public1_http" {
  security_group_id                 = aws_security_group.public1_sg.id
  type                              = "ingress"
  from_port                         = 80
  to_port                           = 80
  protocol                          = "tcp"
  cidr_blocks                       = ["0.0.0.0/0"]
}

## Egress rule
resource "aws_security_group_rule" "public_outbound" {
  security_group_id                 = aws_security_group.public1_sg.id
  type                              = "egress"
  from_port                         = 0
  to_port                           = 0
  protocol                          = "-1"
  cidr_blocks                       = ["0.0.0.0/0"]
}