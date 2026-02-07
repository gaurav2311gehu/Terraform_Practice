terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_s3_bucket" "app_bucket" {
  bucket = "my-unique-bucket-for-practice-92741"

  tags = {
    Name        = "AppBucket"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.app_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "app_table" {
  name         = "app-table"
  billing_mode = "PAY_PER_REQUEST"

  hash_key  = "id"
  range_key = "createdAt"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "createdAt"
    type = "S"
  }

  tags = {
    Name        = "AppTable"
    Environment = "dev"
  }
}
