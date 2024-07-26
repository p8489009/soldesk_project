output "lambda_error_topic_arn" {
  value = aws_sns_topic.lambda_error_notifications.arn
}

output "lambda_success_topic_arn" {
  value = aws_sns_topic.lambda_success_notifications.arn
}
