resource "aws_security_group" "eks_nodes_sg" {
  name                                                  = "${var.eks_cluster_name}_node_sg"
  description                                           = "Security group for all nodes in the cluster"
  vpc_id                                                = var.vpc_id

  egress {
    from_port                                           = 0
    to_port                                             = 0
    protocol                                            = "-1"
    cidr_blocks                                         = ["0.0.0.0/0"]
  }

   tags                                                 = {
    Name                                                = "${var.eks_cluster_name}_node_sg"
    "kubernetes.io/cluster/${var.eks_cluster_name}"     = "${var.eks_cluster_name}"
    Environment                                         = "${var.environment}"
  }
}

resource "aws_security_group_rule" "nodes" {
  description                                           = "Allow nodes to communicate with each other"
  from_port                                             = 0
  protocol                                              = "-1"
  security_group_id                                     = aws_security_group.eks_nodes_sg.id
  source_security_group_id                              = aws_security_group.eks_nodes_sg.id
  to_port                                               = 65535
  type                                                  = "ingress"
}

resource "aws_security_group_rule" "nodes_inbound" {
  description                                           = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                                             = 1025
  protocol                                              = "tcp"
  security_group_id                                     = aws_security_group.eks_nodes_sg.id
  source_security_group_id                              = aws_security_group.eks_cluster_sg.id
  to_port                                               = 65535
  type                                                  = "ingress"
}