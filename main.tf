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
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
}

variable "aws_access_key" {}

variable "aws_secret_key" {}


resource "aws_instance" "terraform-ec2" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
}


locals {
  aws_access_key = lookup(var.aws_access_key, AWS_ACCESS_KEY_ID)
  aws_secret_key = lookup(var.aws_secret_key, AWS_SECRET_ACCESS_KEY)
}