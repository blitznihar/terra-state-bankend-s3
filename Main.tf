provider "aws" {
  access_key = "${var.aws_access_key["${var.env}"]}"
  secret_key = "${var.aws_secret_key["${var.env}"]}"
  region     = "${var.region["${var.env}"]}"
}
# terraform state file setup
# create an S3 bucket to store the state file in
resource "aws_s3_bucket" "terraform-state-storage-s3" {
  bucket = "terraform-remote-state-storage-s3"

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

# resource "aws_s3_bucket_policy" "policy_terraform-state-storage-s3" {
#   bucket = "${aws_s3_bucket.terraform-state-storage-s3}"
#   policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": "s3:ListBucket"
#     },
#     {
#       "Effect": "Allow",
#       "Action": ["s3:GetObject", "s3:PutObject"]
#     }
#   ]
# }
# POLICY
# }

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

# resource "aws_iam_policy" "dynamodb-terraform-state-lock-policy" {
#   aws_dynamodb_table = "${aws_dynamodb_table.dynamodb-terraform-state-lock}"
#   policy             = <<EOF
#   {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": [
#         "dynamodb:GetItem",
#         "dynamodb:PutItem",
#         "dynamodb:DeleteItem"
#       ]
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_policy_attachment" "test-attach"{


# }
