terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
    access_key = aws_access_key
    secret_key = aws_secret_key
}



resource "aws_instance" "terraform-ec2" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
}

locals {
  aws_access_key = lookup(aws_access_key, AWS_ACCESS_KEY_ID)
  aws_secret_key = lookup(aws_secret_key, AWS_SECRET_ACCESS_KEY)
}