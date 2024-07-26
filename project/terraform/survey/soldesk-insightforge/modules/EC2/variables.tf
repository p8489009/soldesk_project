variable "region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "key_name" {
  description = "The name of the key pair to use for the instance"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the instance in"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the instance"
  type        = string
}

variable "instance_name" {
  description = "The name to tag on the instance"
  type        = string
}


variable "mywebserver_iam_instance_profile_name" {
  description = "The name of the IAM instance profile to attach to the EC2 instance"
  type        = string
}