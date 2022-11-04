output "region" {
    value = var.region
}

output "project_name"   {
    value = var.project_name
}

output "environment"   {
    value = var.environment
}

output "eks_cluster_name"   {
    value = var.eks_cluster_name
}

output "prod_eks_01_db_id" {
  value = aws_db_instance.rds.id
}

