include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/s3"
}

locals {
  env_vars    = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

inputs = merge(
  local.common_vars.inputs,
  local.env_vars.inputs
)
