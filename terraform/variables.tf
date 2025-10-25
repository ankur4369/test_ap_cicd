variable "file_name" {
    description = "Name of the file"
}

variable "content" {
    default = "This is my first file. Hello Terraform!"
}

variable "aws_region" {
    description = "AWS Region"
    type = string
    default = "us-east-1"
}

variable "ami_id" {
    description = "AMI ID for the EC2 instance"
    type = string
    default = "ami-07860a2d7eb515d9a"
}

variable "instance_type" {
    description = "EC2 instance type"
    type = string
    default = "t2.micro"
}

variable "key_name" {
    description = "Name of the existing string"
    type = string
    default = "my-first-key"
}

variable "project_name" {
    description = "Project name for tagging and file naming"
    type = string
    default = "terraform-cpc-dlg"
}