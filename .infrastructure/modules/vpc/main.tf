terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.46"
    }
  }
}

data "aws_availability_zones" "available" {}

locals {
  cidr_part = trimsuffix(var.cidr, ".0.0")
}

module "vpc" {
  source                  = "terraform-aws-modules/vpc/aws"
  version                 = "5.18.0"
  name                    = "${var.deployment_prefix}-vpc"
  cidr                    = "${var.cidr}/16"
  azs                     = data.aws_availability_zones.available.names
  private_subnets         = ["${local.cidr_part}.11.0/24", "${local.cidr_part}.12.0/24"]
  public_subnets          = ["${local.cidr_part}.21.0/24", "${local.cidr_part}.22.0/24"]
  enable_nat_gateway      = true
  single_nat_gateway      = true
  one_nat_gateway_per_az  = false
  map_public_ip_on_launch = true
}

resource "aws_security_group" "allow_all" {
  name        = "allow-all"
  description = "Allow all inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}