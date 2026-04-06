terraform {
  backend "s3" {}
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "app_bucket" {
  bucket = "${var.env_name}-app-bucket-${data.aws_caller_identity.current.account_id}-${random_id.suffix.hex}"
  tags = {
    Name        = "${var.env_name}-app-bucket"
    Environment = var.env_name
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}

# Enable Versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.app_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
# Enable Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.app_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
