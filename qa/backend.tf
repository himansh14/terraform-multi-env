terraform {
  backend "s3" {
    bucket         = "terraform-state-himanshu"
    key            = "qa/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-backend-lock"
    encrypt        = true
  }
}