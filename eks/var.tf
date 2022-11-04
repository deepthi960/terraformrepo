##### Globale Variables #####################
variable "region" {}
variable "project_name" {}
variable "eks_cluster_name" {}
variable "environment" {}
variable "availability_zones" {}
variable "eks_cluster_version" {}
variable "disk_size" {}
variable "endpoint_private_access" {}
variable "endpoint_public_access" {}
variable "eks_cluster_subnet_ids" {}
variable "private_subnet_ids" {}
variable "public_subnet_ids" {}
variable "cpu_ami_type" {}
variable "cpu_instance_types" {}
variable "cpu_desired_size" {}
variable "cpu_max_size" {}
variable "cpu_min_size" {}
variable "asterisk_ami_type" {}
variable "asterisk_instance_types" {}
variable "asterisk_desired_size" {}
variable "asterisk_max_size" {}
variable "asterisk_min_size" {}
variable "general_ami_type" {}
variable "general_instance_types" {}
variable "general_desired_size" {}
variable "general_max_size" {}
variable "general_min_size" {}
variable eks_cluster_sg {}
variable eks_nodes_sg {}
variable vpc_id {}
variable release_version {}
variable capacity_type {}
variable force_update_version {}
variable "addons" {
  type = list(object({
    name    = string
    version = string
  }))

  default = [
    {
      name    = "kube-proxy"
      version = "v1.22.11-eksbuild.2"
    },
    {
      name    = "vpc-cni"
      version = "v1.11.3-eksbuild.1"
    },
    {
      name    = "coredns"
      version = "v1.8.7-eksbuild.1"
    },
    {
      name    = "aws-ebs-csi-driver"
      version = "v1.10.0-eksbuild.1"
    }
  ]
}