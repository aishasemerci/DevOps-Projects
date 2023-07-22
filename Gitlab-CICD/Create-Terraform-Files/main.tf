terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "2.36.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}


resource "aws_instance" "mentor-instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.mykey
  count = 3
  vpc_security_group_ids = [aws_security_group.tf-mentor-sec-gr.id]
  user_data = file("userdata.sh")

  tags = {
    Name = var.mentor-server-tag
    Order = "Instance ${count.index + 1}"
  }
}

resource "aws_security_group" "tf-mentor-sec-gr" {
  name = var.mentor-server-secgr
  tags = {
    Name = var.mentor-server-secgr
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}