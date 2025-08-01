provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "glue_bucket" {
  bucket = var.bucket_name
  force_destroy = true

  tags = {
    Name = var.bucket_name
    Environment = "dev"
  }
}

resource "aws_s3_object" "glue_script" {
  bucket = aws_s3_bucket.glue_bucket.id
  key = "scripts/glue_job_script.py"
  source = var.script_path
  etag = filemd5(var.script_path)
}

resource "aws_glue_job" "glue_job" {
  name = var.job_name
  role_arn = var.iam_role_arn

  command {
    name = "glueetl"
    script_location = "s3://${aws_s3_bucket.glue_bucket.id}/${aws_s3_object.glue_script.key}"
    python_version = "3"
  }

  glue_version = "4.0"
  max_capacity = 2.0
  timeout = 10

  default_arguments = {
    "--TempDir" = "s3://${aws_s3_bucket.glue_bucket.id}/temp/"
    "--job-language" = "python"
  }
}
