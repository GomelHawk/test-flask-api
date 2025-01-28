terraform {
  required_version = ">= 1.3.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.83"
    }
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.33.1"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnet_ids      = var.subnets
  vpc_id          = var.vpc_id

  enable_cluster_creator_admin_permissions = true

  cluster_endpoint_public_access = true

  enable_irsa = true

  eks_managed_node_groups = {
    default = {
      desired_capacity = var.node_group.desired_size
      max_capacity     = var.node_group.max_size
      min_capacity     = var.node_group.min_size
      instance_type    = var.node_group.instance_type
    }
  }
}
