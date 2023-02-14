provider "aws" {
  region     = "us-east-1"
  access_key = "${secrets.AWS_ACCESS_KEY_ID}"
  secret_key = "${secrets.AWS_SECRET_ACCESS_KEY}"
}

resource "aws_instance" "terraform-ec2" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
}