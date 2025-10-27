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

resource "aws_s3_bucket" "tf_state" {
  bucket = "cpc-ankurp-tf-bucket"
  versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "tf_lock" {
  name         = "terraform-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
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

# Generate a new SSH key pair
resource "tls_private_key" "generated_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create AWS key pair using the generated public key
resource "aws_key_pair" "terraform_key" {
  key_name   = "terraform-generated-key"
  public_key = tls_private_key.generated_key.public_key_openssh
}

resource "aws_instance" "example" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = aws_key_pair.terraform_key.key_name
    vpc_security_group_ids = [aws_security_group.ec2_sg.id]

    user_data = <<-EOF
            #!/bin/bash
            echo "Hello from Terraform EC2 instance for Ankur Pandey DLG Swan lane Office" > /home/ec2-user/hello.txt
            EOF
    tags = {
        name = local.instance_name
    }
}

# Optional: Save the private key locally
resource "local_file" "private_key" {
  content  = tls_private_key.generated_key.private_key_pem
  filename = "${path.module}/terraform-generated-key.pem"
  file_permission = "0600"
}

resource "local_file" "example" {
    filename = "${path.module}/hello.txt"
    content = local.content
}