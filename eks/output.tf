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

output "eks_cluster_role" {
    value   =  aws_iam_role.eks_cluster_role.id
}

output "eks_cluster_sg_id" {
    value   =  aws_security_group.eks_cluster_sg.id
}

output "eks_nodes_sg_id" {
    value   =  aws_security_group.eks_nodes_sg.id
}

output "eks_cluste_id" {
    value = aws_eks_cluster.eks_cluster.id
}

output "cpu_node_group_id" {
    value = aws_eks_node_group.cpu.id
}

output "general_node_group_id" {
    value = aws_eks_node_group.general.id
}

output "asterisk_node_group_id" {
    value = aws_eks_node_group.asterisk.id
}