terraform {
  source = "../../modules//vpc/"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "ecr" {
  config_path = "../ecr/"

  # Configure mock outputs for the "init", "validate", "plan", etc. commands
  # that are returned when there are no outputs available (e.g the module hasn't been applied yet.)
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "terragrunt-info", "show"]
  mock_outputs = {
    repository_url = "1234567890.fake.dkr.ecr.us-east-1.amazonaws.com/dkosh-app"
  }
}

inputs = {
  cidr = "10.0.0.0"
}
