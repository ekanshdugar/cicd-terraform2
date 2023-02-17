terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.8.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
    access_key = var.aws_access_key_id
    secret_key = var.aws_secret_access_key
}

variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}

resource "aws_instance" "terraform-ec2" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  key_name      = "ansible-key1"
  
}

