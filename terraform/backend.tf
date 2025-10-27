terraform {
    backend "s3" {
        bucket = "cpc-ankurp-tf-bucket"
        key = "terraform.tfstate"
        region = "us-east-1"
    }
}