variable "region" {
  description = "The AWS region"
  type        = string
}


variable "nginx_web_acl_arn" {
  description = "The ARN of the NGINX WAF Web ACL"
  type        = string
}

variable "tomcat_web_acl_arn" {
  description = "The ARN of the TOMCAT WAF Web ACL"
  type        = string
}

variable "nginx_s3_bucket_arn" {
  description = "The ARN of the S3 bucket for NGINX WAF logs"
  type        = string
}

variable "tomcat_s3_bucket_arn" {
  description = "The ARN of the S3 bucket for TOMCAT WAF logs"
  type        = string
}