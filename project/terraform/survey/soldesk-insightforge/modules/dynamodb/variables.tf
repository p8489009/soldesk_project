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

variable "environment" {
  description = "The environment of the DynamoDB table"
  type        = string
}
