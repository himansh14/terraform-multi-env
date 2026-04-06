locals {
  env_name   = "uat"
  cidr_block = "10.20.0.0/16"
}

inputs = {
  env_name   = local.env_name
  cidr_block = local.cidr_block
}
