terraform {
    required_providers {
        local = {
            source = "hashicorp/local"
            version = "~> 2.0"
        }
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
    region = var.aws_region
}


resource "aws_security_group" "ec2_sg" {
    name = "terraform-ec2-sg"
    description = "Allow inbound SSH traffic"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "cpc-ec2-sg"
    }
}

resource "aws_key_pair" "my_key" {
  key_name   = "my-first-key"
  public_key = file("~/.ssh/id_rsa.pub")  # path to your SSH public key
}

resource "aws_instance" "example" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = aws_key_pair.my_key.key_name
    vpc_security_group_ids = [aws_security_group.ec2_sg.id]

    user_data = <<-EOF
            #!/bin/bash
            echo "Hello from Terraform EC2 instance for Ankur Pandey DLG Swan lane Office" > /home/ec2-user/hello.txt
            EOF
    tags = {
        name = local.instance_name
    }
}


resource "local_file" "example" {
    filename = "${path.module}/hello.txt"
    content = local.content
}