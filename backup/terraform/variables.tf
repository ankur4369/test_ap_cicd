variable "aws_region" {
  default = "us-east-1"
}

variable "bucket_name" {
  description = "Name of S3 bucket"
  type = string
  default = "my-github-s3-glue-bucket-082025"
}

variable "job_name" {
  default = "my_first_glue_job_ap_082025"
}

variable "iam_role_arn" {
  type = string
  description = "IAM Role ARN for AWS Glue"
}

variable "script_path" {
  default = "glue_job_script.py"
}
