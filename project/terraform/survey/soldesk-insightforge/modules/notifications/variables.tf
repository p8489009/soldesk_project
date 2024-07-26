variable "region" {
  description = "The AWS region to create resources in"
  type        = string
}

variable "email_endpoint" {
  description = "The email address to subscribe to the SNS topic"
  type        = string
  default     = "p8489009@gmail.com"
}
