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
}

resource "aws_instance" "terraform-ec2" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
}