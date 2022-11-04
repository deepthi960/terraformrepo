# Create Elastic IP
resource "aws_eip" "ng-eip1" {
  vpc                                                       = true
}

# Create NAT Gateway
resource "aws_nat_gateway" "ng1" {
  allocation_id                                             = aws_eip.ng-eip1.id
  subnet_id                                                 = aws_subnet.public_subnet[0].id

  tags                                                      = {
    Name                                                    = "${var.eks_cluster_name}_ng"
    "kubernetes.io/cluster/${var.eks_cluster_name}"         =   "${var.eks_cluster_name}"
    Environment                                             =   "${var.environment}"
  }
  }

