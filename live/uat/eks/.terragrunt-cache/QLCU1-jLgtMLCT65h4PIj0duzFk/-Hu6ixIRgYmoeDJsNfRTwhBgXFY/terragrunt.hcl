include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/eks"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "iam" {
  config_path = "../iam"
}

inputs = {
  env_name         = "qa"
  subnet_ids       = dependency.vpc.outputs.private_subnet_ids
  cluster_role_arn = dependency.iam.outputs.cluster_role_arn
  node_role_arn    = dependency.iam.outputs.node_role_arn
}
