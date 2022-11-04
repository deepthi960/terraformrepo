##### Globale Variables #####################
variable "region" {}
variable "project_name" {}
variable "eks_cluster_name" {}
variable "environment" {}
variable "availability_zones" {}
##### Network Variables #####################
variable "vpc_cidr_block" {}
variable "public_subnet_cidr_blocks" {}
variable "private_subnet_cidr_blocks" {}
variable "db_subnet_cidr_blocks" {}
variable "public_subnet_tag_name" {}
variable "private_subnet_tag_name" {}
variable "db_subnet_tag_name" {}
variable "public_rt_tag_name" {}
variable "db_subnet_group_name" {}
