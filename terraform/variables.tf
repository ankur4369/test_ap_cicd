variable "aws_region" {
  default = "us-east-1"
}

variable "bucket_name" {
  description = "Name of S3 bucket"
  type = string
  default = "my-github-s3-bucket-apdlgcog"
}
