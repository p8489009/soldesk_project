variable "region" {
  description = "The AWS region to create resources in."
  type        = string
}

variable "ami_id" {
  description = "The ID of the AMI to use for the launch templates."
  type        = string
}

variable "key_name" {
  description = "The key pair to use for the instances."
  type        = string
}

variable "nginx_pub_2a_subnet" {
  description = "The ID of the NGINX public subnet in ap-northeast-2a."
  type        = string
}

variable "nginx_pub_2c_subnet" {
  description = "The ID of the NGINX public subnet in ap-northeast-2c."
  type        = string
}

variable "tomcat_pri_2a_subnet" {
  description = "The ID of the TOMCAT private subnet in ap-northeast-2a."
  type        = string
}

variable "tomcat_pri_2c_subnet" {
  description = "The ID of the TOMCAT private subnet in ap-northeast-2c."
  type        = string
}

variable "db_pri_2a_subnet" {
  description = "The ID of the DB private subnet in ap-northeast-2a."
  type        = string
}

variable "db_pri_2c_subnet" {
  description = "The ID of the DB private subnet in ap-northeast-2c."
  type        = string
}

variable "nginx_security_group" {
  description = "The security group ID for the NGINX instances."
  type        = string
}

variable "tomcat_security_group" {
  description = "The security group ID for the TOMCAT instances."
  type        = string
}

variable "db_security_group" {
  description = "The security group ID for the DB instances."
  type        = string
}

variable "asg_iam_instance_profile_arn" {
  description = "The ARN of the IAM instance profile to use for the launch template"
  type        = string
}


variable "db_asg_iam_instance_profile_arn" {
  description = "The ARN of the IAM instance profile to use for the launch template"
  type        = string
}