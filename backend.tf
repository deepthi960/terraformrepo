terraform {
  backend "s3" {
    bucket    = "demo-terraform"
    key       = "dev_eks_01/terraform.tfstate"
    region    = "us-east-1"
    profile   = "terraform-user"
  }
}