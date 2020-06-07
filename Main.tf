provider "random" {
  
}
resource "random_string" "lower" {
  length  = 8
  upper   = false
  lower   = true
  number  = false
  special = false
}

provider "aws" {
  access_key = "${var.aws_access_key["${var.env}"]}"
  secret_key = "${var.aws_secret_key["${var.env}"]}"
  region     = "${var.region["${var.env}"]}"
}


resource "aws_s3_bucket" "terraform-state-storage-s3" {
  bucket = "terraform-remote-state-storage-s3-${random_string.lower.result}"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    "Name"    = "S3 Remote Terraform State Store"
    "Purpose" = "Terraform"
  }

}


resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "terraform-state-lock-dynamo"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    "Name"    = "DynamoDB Terraform State Lock Table"
    "Purpose" = "Terraform"
  }
}
