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
    access_key = "AKIATJM2SKFUVDTHI2PY"
    secret_key = "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"
}

resource "aws_instance" "terraform-ec2" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
}