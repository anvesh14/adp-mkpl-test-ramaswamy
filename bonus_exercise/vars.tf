# AWS Config

variable "aws_access_key" {
default = "AWS_ACCESS_KEY_ID"
}

variable "aws_secret_key" {
default = "AWS_SECRET_ACCESS_KEY"
}

variable "aws_region" {
default = "us-west-2"
}

variable "cidr_block" {
default = "10.0.0.0/16"
}

variable "instance_type" {
default = "dedicated"
}

variable "aws_ami" {
default = "ami-0a74bfeb190bd404f"
}

variable "aws_bucket" {
default = "adp-mkpl-test-ramaswamy"
}

variable "s3_acl" {
default = "public"
}

variable "aws_privatekey" {
default = "AWS_PRIVATEKEY"
}

variable "aws_user" {
default = "AWS_USER "
}
