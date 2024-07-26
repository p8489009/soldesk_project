variable "log_group_name" {
  description = "The name of the log group to apply the metric filter to"
  type        = string
}

variable "error_metric_name" {
  description = "The name of the CloudWatch error metric"
  type        = string
}

variable "error_metric_namespace" {
  description = "The namespace of the CloudWatch error metric"
  type        = string
}

variable "error_metric_value" {
  description = "The value of the CloudWatch error metric"
  type        = string
}

variable "error_default_value" {
  description = "The default value of the CloudWatch error metric"
  type        = number
}

variable "error_metric_unit" {
  description = "The unit of the CloudWatch error metric"
  type        = string
}

variable "success_metric_name" {
  description = "The name of the CloudWatch success metric"
  type        = string
}

variable "success_metric_namespace" {
  description = "The namespace of the CloudWatch success metric"
  type        = string
}

variable "success_metric_value" {
  description = "The value of the CloudWatch success metric"
  type        = string
}

variable "success_default_value" {
  description = "The default value of the CloudWatch success metric"
  type        = number
}

variable "success_metric_unit" {
  description = "The unit of the CloudWatch success metric"
  type        = string
}

variable "lambda_error_topic_arn" {
  description = "The ARN of the SNS topic for Lambda errors"
  type        = string
}

variable "lambda_success_topic_arn" {
  description = "The ARN of the SNS topic for Lambda successes"
  type        = string
}

