![CI](https://github.com/blitznihar/terra-state-bankend-s3/workflows/CI/badge.svg)
# terra-state-bankend-s3
## Terraform state bankend S3 with Dynamodb for lock management




## Usage

1. Create file name: 
```terraform.tfvars```
2. With below content: 
```
aws_access_key = {
  dev  = "<<access_key goes here>>"
  prod = "<<access_key goes here>>"
}

aws_secret_key = {
  dev  = "<<secret_key goes here>>"
  prod = "<<secret_key goes here>>"
}

region = {
  dev  = "<<region goes here>>"
  prod = "<<region goes here>>"
}
```
3. `terraform init`
4. `terraform plan`
5. `terraform apply`

## Cleanup

###### To destroy run: `terraform destroy`
