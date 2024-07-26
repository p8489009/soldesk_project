resource "aws_sns_topic" "lambda_error_notifications" {
  name = "LambdaErrorNotifications"
}

resource "aws_sns_topic_subscription" "lambda_error_subscription" {
  topic_arn = aws_sns_topic.lambda_error_notifications.arn
  protocol  = "email"
  endpoint  = "p8489009@gmail.com"
}

resource "aws_sns_topic" "lambda_success_notifications" {
  name = "LambdaSuccessNotifications"
}

resource "aws_sns_topic_subscription" "lambda_success_subscription" {
  topic_arn = aws_sns_topic.lambda_success_notifications.arn
  protocol  = "email"
  endpoint  = "p8489009@gmail.com"
}
