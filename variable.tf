variable "env" {
  description = "env: dev or prod"
}

      variable "aws_access_key" {
  description = "For aws_access_key"
  type        = "map"
}

variable "aws_secret_key" {
  description = "For aws_secret_key"
  type        = "map"
}

variable "region" {
  description = "For AWS Region"
   type        = "map"
}