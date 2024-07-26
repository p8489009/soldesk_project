variable "s3_bucket" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "s3_key" {
  description = "The key of the object in the S3 bucket"
  type        = string
}

variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role that Lambda will assume"
  type        = string
}

variable "handler" {
  description = "The function entry point in your code"
  type        = string
}

variable "runtime" {
  description = "The runtime environment for the Lambda function"
  type        = string
}

variable "dynamodb_table" {
  description = "The DynamoDB table name"
  type        = string
}

variable "source_arn" {
  description = "The source ARN for the Lambda permission"
  type        = string
}
