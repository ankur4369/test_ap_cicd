data "aws_iam_role" "glue_role" {
    name = "GithubAdminRole"
}

data "aws_s3_bucket" "glue_bucket" {
    bucket = "cpc-ankurp-tf-bucket"
}