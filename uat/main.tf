module "vpc" {
  source     = "../modules/vpc"
  env_name   = "uat"
  cidr_block = "10.20.0.0/16"
}

module "s3" {
  source   = "../modules/s3"
  env_name = "uat"
}

module "iam" {
  source   = "../modules/iam"
  env_name = "uat"
}

module "eks" {
  source = "../modules/eks"

  env_name         = "uat"
  subnet_ids       = module.vpc.private_subnet_ids
  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn
}