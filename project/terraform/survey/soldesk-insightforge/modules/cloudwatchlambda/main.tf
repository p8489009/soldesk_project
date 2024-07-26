resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.dynamodb_Surveys_items.arn
}

resource "aws_cloudwatch_event_rule" "dynamodb_Surveys_items" {
  name        = var.name
  description = "Trigger Lambda function every 30 minutes"
  schedule_expression = "cron(0,30 * * * ? *)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.dynamodb_Surveys_items.name
  target_id = "Surveys-items"
  arn       = var.lambda_function_arn
}

output "cloudwatch_event_rule_arn" {
  value = aws_cloudwatch_event_rule.dynamodb_Surveys_items.arn
}