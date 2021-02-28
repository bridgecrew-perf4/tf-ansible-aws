variable "is_production" {
  type = bool
}

variable "aws_region" {
  type = string
}

variable "aws_profile" {
  type = string
}


variable "project" {
  type = string
  default = "wordpress-tf-deplyment"
}


variable "env" {
  type = string
}

variable "instance_type" {
  type = string
}

# aws --profile home ec2 import-key-pair --key-name "user-personal-key" --public-key-material fileb://$HOME/.ssh/id_rsa.pub
variable "ec2_key_name" {
  type = string
}

variable "ec2_ami" {
  type = string
}


variable "s3_bucket" {
  type = string
}





variable "rds_instance_type" {
  type = string
}

variable "rds_db_size" {
  type = number
}


variable "rds_db_name" {
  type = string
}


variable "rds_db_user" {
  type = string
}


variable "rds_db_pass" {
  type = string 
}





