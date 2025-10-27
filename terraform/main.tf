terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
    region = var.aws_region
}

resource "aws_s3_object" "code_script" {
    bucket = var.s3_code_bucket
    key = "scripts/my-first-glue-code.py"
    source = "${path.module}/my_first_glue_script.py"
    etag = filemd5("${path.module}/my_first_glue_script.py")
}

resource "aws_glue_job" "python_job" {
    name = "daily-python-job"
    role_arn = data.aws_iam_role.glue_role.arn

    command {
        name = "glueetl"
        script_location = "s3://${data.aws_s3_bucket.glue_bucket.bucket}/${aws_s3_object.code_script.key}"
        python_version = "3"
    }

    glue_version = "3.0"
    max_capacity = 1.0
    timeout = 10

    execution_property {
        max_concurrent_runs = 1
    }

    default_arguments = {
        "--job-language" = "python"
        "--enable-continuous-cloudwatch-log" = "true"
        "--enable-metrics" = "true"
    }
}

resource "aws_glue_trigger" "daily_trigger" {
    name = "daily-python-trigger"
    type = "SCHEDULED"
    schedule = "cron(15 7 * * ? *)"

    actions {
        job_name = aws_glue_job.python_job.name
    }

    start_on_creation = true
}