variable "region" {
  description = "The region where resources will be created"
  type        = string
}

variable "nginx_alb_arn" {
  description = "The ARN of the NGINX ALB to associate with WAF"
  type        = string
}

variable "tomcat_alb_arn" {
  description = "The ARN of the TOMCAT ALB to associate with WAF"
  type        = string
}
