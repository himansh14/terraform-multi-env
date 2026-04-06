locals {
  env_name   = "qa"
  cidr_block = "10.10.0.0/16"
}

inputs = {
  env_name   = local.env_name
  cidr_block = local.cidr_block
}
