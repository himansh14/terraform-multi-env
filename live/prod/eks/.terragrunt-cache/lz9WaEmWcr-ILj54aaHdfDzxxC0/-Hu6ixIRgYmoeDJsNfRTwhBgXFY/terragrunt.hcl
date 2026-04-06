include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/eks"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "iam" {
  config_path = "../iam"
}

inputs = merge(
  local.common_vars.inputs,
  local.env_vars.inputs,
  {
    subnet_ids       = dependency.vpc.outputs.private_subnet_ids
    cluster_role_arn = dependency.iam.outputs.cluster_role_arn
    node_role_arn    = dependency.iam.outputs.node_role_arn
  }
)
