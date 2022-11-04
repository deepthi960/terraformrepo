output "region" {
    value = var.region
}

output "project_name"   {
    value   =   var.project_name
}

output "environment"   {
    value   =   var.environment
}

output "eks_cluster_name"   {
    value   =   var.eks_cluster_name
}

output "vpc_id"   {
    value   =   aws_vpc.vpc.id
}
output "private_subnet_id"   {
    value = aws_subnet.private_subnet.*.id
}

output "public_subnet_id"   {
    value = aws_subnet.public_subnet.*.id
}

output "db_subnet_group_id"   {
    value = aws_subnet.db_subnet.*.id
}

output  "public_rt" {
    value   =  aws_route_table.public_rt.id
}

output  "private_rt" {
    value   =  aws_route_table.private_rt.id
}

output "igw"   {
    value   =   aws_internet_gateway.igw
}

output "ng1"    {
    value   =   aws_nat_gateway.ng1.id
}

output "public1_sg" {
    value   =   aws_security_group.public1_sg.id
}

output "data_plane_sg" {
    value   =   aws_security_group.data_plane_sg.id
}

output "control_plane_sg" {
    value   =   aws_security_group.control_plane_sg.id
}

output "db_sg_id" {
    value   =   aws_security_group.db_sg.id
}

output "efs_sg_id" {
    value   =   aws_security_group.efs_sg.id
}

