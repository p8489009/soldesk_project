variable "region" {
  description = "The AWS region to create resources in."
  type        = string
}

variable "nginx_subnet_2a" {
  description = "The ID of the NGINX public subnet in ap-northeast-2a."
  type        = string
}

variable "nginx_subnet_2c" {
  description = "The ID of the NGINX public subnet in ap-northeast-2c."
  type        = string
}

variable "nginx_security_group" {
  description = "The security group ID for the NGINX ALB."
  type        = string
}

variable "nginx_target_group_arn" {
  description = "The ARN of the target group for NGINX."
  type        = string
}

variable "tomcat_subnet_2a" {
  description = "The ID of the TOMCAT private subnet in ap-northeast-2a."
  type        = string
}

variable "tomcat_subnet_2c" {
  description = "The ID of the TOMCAT private subnet in ap-northeast-2c."
  type        = string
}

variable "tomcat_security_group" {
  description = "The security group ID for the TOMCAT ALB."
  type        = string
}

variable "tomcat_target_group_arn" {
  description = "The ARN of the target group for TOMCAT."
  type        = string
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate for HTTPS listener."
  type        = string
}


