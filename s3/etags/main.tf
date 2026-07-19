terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.55.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

resource "aws_s3_bucket" "default" {
#   bucket = "my-tf-test-bucket" taking out bucket name allows for name generation
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.default.id
  key    = "myfile.txt"
  source = "myfile.txt"

  etag = filemd5("myfile.txt") # Generate 'hash' for version tracking
}