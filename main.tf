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
    access_key = var.aws_access_key_id
    secret_key = var.aws_secret_access_key
}

variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}

resource "aws_instance" "terraform-ec2" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  key_name      = "ansible-key1"
  iam_instance_profile {
    name = aws_iam_instance_profile.example.name
  }
  
}


resource "aws_iam_instance_profile" "example" {
  name = "example-instance-profile"

  role = aws_iam_role.example.name

  # Allow access to the AWS metadata service
  policy {
    policy_document = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect    = "Allow"
          Action    = "ec2:Describe*"
          Resource  = "*"
        },
        {
          Effect    = "Allow"
          Action    = "ec2messages:Get*"
          Resource  = "*"
        },
        {
          Effect    = "Allow"
          Action    = "ssm:CreateAssociation"
          Resource  = "*"
        },
        {
          Effect    = "Allow"
          Action    = "ssm:GetParameters"
          Resource  = "*"
        },
      ]
    })
  }
}



metadata_options {
  http_tokens = "optional"
  http_put_response_hop_limit = 1
  http_endpoint = "enabled"
}

