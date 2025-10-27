terraform {
  backend "s3" {
    bucket         = "cpc-ankurp-tf-bucket"   # Name from above
    key            = "terraform.tfstate"  # Path within the bucket
    region         = var.aws_region
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}