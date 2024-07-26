variable "region" {
  description = "The region where resources will be created"
  type        = string
}


variable "glue_role_arn" {
  description = "The ARN of the IAM role to be used by Glue Crawlers"
  type        = string
}