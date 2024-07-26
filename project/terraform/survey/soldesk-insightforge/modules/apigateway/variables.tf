variable "name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "description" {
  description = "The description of the API Gateway"
  type        = string
}

variable "lambda_invoke_arn_save_survey_data" {
  description = "The invoke ARN of the SaveSurveyData Lambda function"
  type        = string
}

variable "lambda_invoke_arn_get_survey" {
  description = "The invoke ARN of the GetSurvey Lambda function"
  type        = string
}

variable "lambda_invoke_arn_submit_survey_response" {
  description = "The invoke ARN of the SubmitSurveyResponse Lambda function"
  type        = string
}

variable "lambda_invoke_arn_view_survey" {
  description = "The invoke ARN of the ViewSurvey Lambda function"
  type        = string
}

variable "stage_name" {
  description = "The stage name for the API deployment"
  type        = string
  default     = "test"
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate in us-east-1"
  type        = string
}

variable "custom_domain_name" {
  description = "The custom domain name for the API Gateway"
  type        = string
}