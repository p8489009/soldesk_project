variable "region" {
  description = "The AWS region to create resources in."
  type        = string
}

variable "nginx_pub_2a_launch_template_id" {
  description = "The ID of the NGINX public 2A launch template."
  type        = string
}

variable "nginx_pub_2c_launch_template_id" {
  description = "The ID of the NGINX public 2C launch template."
  type        = string
}

variable "tomcat_pri_2a_launch_template_id" {
  description = "The ID of the TOMCAT private 2A launch template."
  type        = string
}

variable "tomcat_pri_2c_launch_template_id" {
  description = "The ID of the TOMCAT private 2C launch template."
  type        = string
}

variable "db_pri_2a_launch_template_id" {
  description = "The ID of the DB private 2A launch template."
  type        = string
}

variable "db_pri_2c_launch_template_id" {
  description = "The ID of the DB private 2C launch template."
  type        = string
}

variable "nginx_pub_2a_subnet" {
  description = "The ID of the NGINX public 2A subnet."
  type        = string
}

variable "nginx_pub_2c_subnet" {
  description = "The ID of the NGINX public 2C subnet."
  type        = string
}

variable "tomcat_pri_2a_subnet" {
  description = "The ID of the TOMCAT private 2A subnet."
  type        = string
}

variable "tomcat_pri_2c_subnet" {
  description = "The ID of the TOMCAT private 2C subnet."
  type        = string
}

variable "db_pri_2a_subnet" {
  description = "The ID of the DB private 2A subnet."
  type        = string
}

variable "db_pri_2c_subnet" {
  description = "The ID of the DB private 2C subnet."
  type        = string
}

variable "nginx_target_group_arn" {
  description = "The ARN of the NGINX target group."
  type        = string
}

variable "tomcat_target_group_arn" {
  description = "The ARN of the TOMCAT target group."
  type        = string
}
