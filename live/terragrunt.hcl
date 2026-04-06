locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

inputs = merge(
  local.common_vars.inputs
)

remote_state {
  backend = "s3"

  config = {
    bucket         = "terraform-state-himanshu"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-backend-lock"
    encrypt        = true
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"

  contents = <<EOF
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}
EOF
}
