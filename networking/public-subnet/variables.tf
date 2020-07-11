variable "account_id" {
  description = "The ID of the account"
  type        = string
}

variable "availability_zone" {
  description = "The Availability Zone to create the subnet in"
  type        = string
}

variable "subnet_cidr" {
  description = "The intended CIDR range of the subnet"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "tfstate_global_bucket" {
  description = "The S3 bucket that holds Terraform state"
  type        = string
}

variable "tfstate_global_bucket_region" {
  description = "The region of the S3 bucket that holds Terraform state"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the account VPC"
  type        = string
}

variable "vpc_internet_gateway_id" {
  description = "The ID of the VPC Internet Gateway"
  type        = string
}
