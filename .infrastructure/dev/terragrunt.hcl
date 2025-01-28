remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "dkosh-terragrunt-states"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = "dkosh-terragrunt-states"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = var.aws_region
  default_tags {
    tags = var.default_tags
  }
}

variable "aws_region" {
  description = "AWS Region"
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags."
}
EOF
}

locals {
  aws_region        = "us-east-1"
  deployment_prefix = "dkosh-terragrunt"
}

inputs = {
  aws_region        = local.aws_region
  deployment_prefix = local.deployment_prefix
  default_tags = {
    "Environment"      = "dev",
    "DeployedBy"       = "DKoshelenko",
    "DeploymentPrefix" = local.deployment_prefix
  }
}
