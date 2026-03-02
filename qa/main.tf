module "vpc" {
  source     = "../modules/vpc"
  env_name   = "qa"
  cidr_block = "10.10.0.0/16"
}

module "s3" {
  source   = "../modules/s3"
  env_name = "qa"
}

module "iam" {
  source   = "../modules/iam"
  env_name = "qa"
}

module "eks" {
  source = "../modules/eks"

  env_name         = "qa"
  subnet_ids       = module.vpc.private_subnet_ids
  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn
}