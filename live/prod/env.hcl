locals {
  env_name   = "prod"
  cidr_block = "10.30.0.0/16"
}

inputs = {
  env_name   = local.env_name
  cidr_block = local.cidr_block
}
