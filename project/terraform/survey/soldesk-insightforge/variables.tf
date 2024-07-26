variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "ap-northeast-2"
}

variable "s3_bucket_name" {
  description = "The name of the existing S3 bucket"
  type        = string
  default     = "aws-lambda-function-phj"
}

variable "api_gateway_name" {
  description = "The name of the API Gateway"
  type        = string
  default = "survey"
}

variable "api_gateway_description" {
  description = "The description of the API Gateway"
  type        = string
  default = ""
}

variable "api_gateway_stage_name" {
  description = "The stage name for the API deployment"
  type        = string
  default     = "test"
}

variable "surveys_table_name" {
  description = "The name of the Surveys DynamoDB table"
  type        = string
  default     = "Surveys"
}

variable "survey_responses_table_name" {
  description = "The name of the SurveyResponses DynamoDB table"
  type        = string
  default     = "SurveyResponses"
}


variable "certificate_arn_api" {

  type        = string
  default = "arn:aws:acm:ap-northeast-2:533267020503:certificate/6f2fb85a-9198-4134-bb27-08ef2d1d1792"

}
variable "custom_domain_name" {

  type        = string
  default = "api.soldesk-insightforge.site"

}
variable "cloudfront_zone_id" {

  type        = string
  default = "Z03793083DQ4O8GUVIW7U"

}

variable "cloudfront_certificate" {

  type        = string
  default = "arn:aws:acm:us-east-1:533267020503:certificate/664db40e-7f9f-4dbc-b2e7-b43042b36be3"

}