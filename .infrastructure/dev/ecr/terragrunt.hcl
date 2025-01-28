terraform {
  source = "../../modules//ecr/"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  repository_name = "dkosh-dev-app"
}
