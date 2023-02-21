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

resource "aws_iam_role" "example1-1" {
  name = "example1-1-role"
  
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


resource "aws_iam_role" "example2" {
  name = "example2-role"
 
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


# resource "aws_iam_instance_profile" "example1-1" {
#   name = "example1-1-instance-profile"
#   role = aws_iam_role.example1-1.name
# }

# resource "aws_iam_instance_profile" "example2" {
#   name = "example2-instance-profile"
#   role = aws_iam_role.example2.name
# }


resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow_ssh_"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}

resource "aws_instance" "terraform-ec2-1" {
  ami                  = "ami-0dfcb1ef8550277af"
  instance_type        = "t2.micro"
  key_name             = "ansible-key1"
  iam_instance_profile = "arn:aws:iam::226346815849:instance-profile/example1-instance-profile"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}


resource "aws_instance" "ansible-ec2-1" {
  ami                  = "ami-0dfcb1ef8550277af"
  instance_type        = "t2.micro"
  key_name             = "ansible-key1"
  iam_instance_profile = "arn:aws:iam::226346815849:instance-profile/example2-instance-profile"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

#   connection {
#     type        = "ssh"
#     user        = "ec2-user"
#     host        = aws_instance.ansible-ec2-1.public_ip
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "sudo amazon-linux-extras install -y ansible2",
#     ]
#   }
}







 




# metadata_options {
#   http_tokens = "optional"
#   http_put_response_hop_limit = 1
#   http_endpoint = "enabled"
# }





