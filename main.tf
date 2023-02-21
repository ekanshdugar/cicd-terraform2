terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.44.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
    access_key = var.aws_access_key_id
    secret_key = var.aws_secret_access_key
}

resource "aws_iam_role" "example" {
  name = "example-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_role" "example1" {
  name = "example1-role"
 
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_instance_profile" "example" {
  name = "example-instance-profile"
  role = aws_iam_role.example.name
}

resource "aws_iam_instance_profile" "example1" {
  name = "example1-instance-profile"
  role = aws_iam_role.example1.name
}

variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}

resource "aws_instance" "terraform-ec2" {
  ami                  = "ami-0dfcb1ef8550277af"
  instance_type        = "t2.micro"
  key_name             = "ansible-key1"
  iam_instance_profile = aws_iam_instance_profile.example.name
  vpc_security_group_ids = ["sg-00def51aec8e6034c"]
}


resource "aws_instance" "ansible-ec2" {
  ami                  = "ami-0dfcb1ef8550277af"
  instance_type        = "t2.micro"
  key_name             = "ansible-key1"
  iam_instance_profile = aws_iam_instance_profile.example1.name
  vpc_security_group_ids = ["sg-00def51aec8e6034c"]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = aws_instance.ansible-ec2.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y ansible2",
    ]
  }
}







 




# metadata_options {
#   http_tokens = "optional"
#   http_put_response_hop_limit = 1
#   http_endpoint = "enabled"
# }





