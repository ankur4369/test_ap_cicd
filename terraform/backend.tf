terraform {
    backend "s3" {
        bucket = data.aws_s3_bucket.glue_bucket.bucket
        key = "terraform.tfstate"
        region = "us-east-1"
    }
}