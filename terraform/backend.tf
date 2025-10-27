terraform {
    backend "s3" {
        bucket = "cpc-ankurp-tf-bucket-1"
        key = "terraform.tfstate"
        region = "us-east-1"
    }
}