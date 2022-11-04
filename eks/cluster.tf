resource "aws_eks_cluster" "eks_cluster" {
  name                                                = "${var.eks_cluster_name}"
  version                                             = "${var.eks_cluster_version}"
  role_arn                                            = aws_iam_role.eks_cluster_role.arn
  enabled_cluster_log_types                           = ["api", "authenticator", "audit", "scheduler", "controllerManager"]
  vpc_config {
    security_group_ids                                = [var.eks_cluster_sg, var.eks_nodes_sg]
    endpoint_private_access                           = "${var.endpoint_private_access}"
    endpoint_public_access                            = "${var.endpoint_public_access}"
    subnet_ids                                        = var.eks_cluster_subnet_ids
  }
  tags                                                = {
    Name                                              = "${var.eks_cluster_name}"
    project                                           = "${var.project_name}"
    "kubernetes.io/cluster/${var.eks_cluster_name}"   = "${var.eks_cluster_name}"
    Environment                                       = "${var.environment}"
  }

  depends_on                                          = [aws_iam_role_policy_attachment.eks_cluster_policy]
}


