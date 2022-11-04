#https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html

resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.eks_cluster_name}_cluster_role"
  description = "EKS Cluster Role"
  tags                                                  = {
    Name                                                = "${var.eks_cluster_name}_cluster_role"
    "kubernetes.io/cluster/${var.eks_cluster_name}"     = "${var.eks_cluster_name}"
    Environment                                         = "${var.environment}"
  }
  assume_role_policy = <<POLICY
{
  "Version": "1.0",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.eks_cluster_role.name}"
}