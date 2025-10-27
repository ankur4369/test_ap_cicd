terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"   # Name from above
    key            = "envs/dev/terraform.tfstate"  # Path within the bucket
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}