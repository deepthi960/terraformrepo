### VPC Network Setup
resource "aws_vpc" "vpc" {
  # Your VPC must have DNS hostname and DNS resolution support. 
  # Otherwise, your worker nodes cannot register with your cluster. 

  cidr_block                                                =   "${var.vpc_cidr_block}"
  enable_dns_support                                        =   true
  enable_dns_hostnames                                      =   true
  instance_tenancy                                          =   "default"
    tags                                                    =   {
      "Name"                                                =   "${var.eks_cluster_name}_vpc"
      "kubernetes.io/cluster/${var.eks_cluster_name}"       =   "${var.eks_cluster_name}"
      Environment                                           =   "${var.environment}"
    }
}

# Create the private subnet
resource "aws_subnet" "private_subnet" {
  count                                                     =   length(var.availability_zones)
  vpc_id                                                    =   aws_vpc.vpc.id
  cidr_block                                                =   element(var.private_subnet_cidr_blocks, count.index)
  availability_zone                                         =   element(var.availability_zones, count.index)

  tags                                                      =   {
    Name                                                    =   "${var.private_subnet_tag_name}"
    "kubernetes.io/cluster/${var.eks_cluster_name}"         =   "${var.eks_cluster_name}"
    "kubernetes.io/role/internal-elb"                       =   1
  }
}

# Create the DB private subnet
resource "aws_subnet" "db_subnet" {
  count                                                     =   length(var.availability_zones)
  vpc_id                                                    =   aws_vpc.vpc.id
  cidr_block                                                =   element(var.db_subnet_cidr_blocks, count.index)
  availability_zone                                         =   element(var.availability_zones, count.index)

  tags                                                      =   {
    Name                                                    =   "${var.db_subnet_tag_name}"
    "kubernetes.io/cluster/${var.eks_cluster_name}"         =   "${var.eks_cluster_name}"
    "kubernetes.io/role/internal-elb"                       =   1
  }
}

# Create the public subnet
resource "aws_subnet" "public_subnet" {
  count                                                     =   length(var.availability_zones)
  vpc_id                                                    =   "${aws_vpc.vpc.id}"
  cidr_block                                                =   element(var.public_subnet_cidr_blocks, count.index)
  availability_zone                                         =   element(var.availability_zones, count.index)

  tags = {
    Name                                                    =   "${var.public_subnet_tag_name}"
    "kubernetes.io/cluster/${var.eks_cluster_name}"         =   "${var.eks_cluster_name}"
    "kubernetes.io/role/elb"                                =   1
  }

  map_public_ip_on_launch                                   =   true
}

# Create IGW for the public subnets and attach to VPC
resource "aws_internet_gateway" "igw" {
  vpc_id                                                    =   "${aws_vpc.vpc.id}"

  tags                                                      =   {
    Name                                                    =   "${var.eks_cluster_name}_igw"
    "kubernetes.io/cluster/${var.eks_cluster_name}"         =   "${var.eks_cluster_name}"
    Environment                                             =   "${var.environment}"
  }
}
##### Route Table for Public Subnet #####################################################################################################
# Route the public subnet traffic through the IGW
resource "aws_route_table" "public_rt" {
  vpc_id                                                    =   "${aws_vpc.vpc.id}"

  route {
    cidr_block                                              =   "0.0.0.0/0"
    gateway_id                                              =   "${aws_internet_gateway.igw.id}"
  }

  tags                                                      =   {
    Name                                                    =   "${var.eks_cluster_name}_public_rt"
    "kubernetes.io/cluster/${var.eks_cluster_name}"         =   "${var.eks_cluster_name}"
    Environment                                             =   "${var.environment}"
  }
}

# Route table and subnet associations
resource "aws_route_table_association" "internet_access" {
  count                                                     =   length(var.availability_zones)
  subnet_id                                                 =   "${aws_subnet.public_subnet[count.index].id}"
  route_table_id                                            =   "${aws_route_table.public_rt.id}"
}
##### Route Table for Private Subnet #####################################################################################################
# Route the public subnet traffic through the IGW
resource "aws_route_table" "private_rt" {
  vpc_id                                                    =   "${aws_vpc.vpc.id}"

  route {
    cidr_block                                              =   "0.0.0.0/0"
    gateway_id                                              =   "${aws_nat_gateway.ng1.id}"
  }

  tags                                                      =   {
    Name                                                    =   "${var.eks_cluster_name}_private_rt"
    "kubernetes.io/cluster/${var.eks_cluster_name}"         =   "${var.eks_cluster_name}"
    Environment                                             =   "${var.environment}"
  }
}

# Route table and subnet associations
resource "aws_route_table_association" "endpoint_access" {
  count                                                     =   length(var.availability_zones)
  subnet_id                                                 =   "${aws_subnet.private_subnet[count.index].id}"
  route_table_id                                            =   "${aws_route_table.private_rt.id}"
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name  = "${var.eks_cluster_name}_db_subnet_group"
  subnet_ids = [aws_subnet.db_subnet[0].id, aws_subnet.db_subnet[1].id, aws_subnet.db_subnet[2].id]
  description = "Subnet Group for DB"
  

    tags                                                = {
    Name                                                = "${var.eks_cluster_name}_db_subnet_group"
    "kubernetes.io/cluster/${var.eks_cluster_name}"     = "${var.eks_cluster_name}"
    Environment                                         = "${var.environment}"
  }
}


