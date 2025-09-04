# terraform block
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.11.0"
    }
  }
}
# provider block
provider "aws" {
  region = "us-east-1"
}
# s3-bucket-resouce-block
resource "aws_s3_bucket" "mybucket" {
  bucket = "rakeshperala-bucket"
}
