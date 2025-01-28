terraform {
  source = "../../modules//eks/"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc/"

  # Configure mock outputs for the "init", "validate", "plan", etc. commands
  # that are returned when there are no outputs available (e.g the module hasn't been applied yet.)
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "terragrunt-info", "show"]
  mock_outputs = {
    vpc_id                    = "vpc-fake-id"
    vpc_cidr_block            = "10.0.0.0/16"
    default_security_group_id = "fake-default-sg"

    private_subnets = ["10.0.11.0/24", "10.0.12.0/24"]
    public_subnets  = ["10.0.21.0/24", "10.0.22.0/24"]
  }
}

inputs = {
  vpc_id          = dependency.vpc.outputs.vpc_id
  subnets         = dependency.vpc.outputs.public_subnets
  cluster_name    = "dkosh-terragrunt-cluster"
  cluster_version = "1.27"
  node_group = {
    instance_type = "t3.micro"
    desired_size  = 2
    min_size      = 2
    max_size      = 2
  }
}
