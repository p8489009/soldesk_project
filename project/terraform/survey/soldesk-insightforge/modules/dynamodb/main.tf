resource "aws_dynamodb_table" "surveys_table" {
  name           = var.surveys_table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "SurveyId"

  attribute {
    name = "SurveyId"
    type = "S"
  }

  tags = {
    Name        = var.surveys_table_name
    Environment = var.environment
  }
}

resource "aws_dynamodb_table" "survey_responses_table" {
  name           = var.survey_responses_table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "ResponseId"

  attribute {
    name = "ResponseId"
    type = "S"
  }

  tags = {
    Name        = var.survey_responses_table_name
    Environment = var.environment
  }
}

output "surveys_table_name" {
  value = aws_dynamodb_table.surveys_table.name
}

output "survey_responses_table_name" {
  value = aws_dynamodb_table.survey_responses_table.name
}