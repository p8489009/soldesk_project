
resource "aws_cloudwatch_log_metric_filter" "lambda_error_filter" {
  name           = "LambdaErrorFilter"
  log_group_name = var.log_group_name
  pattern        = "Error processing survey"

  metric_transformation {
    name           = var.error_metric_name
    namespace      = var.error_metric_namespace
    value          = var.error_metric_value
    default_value  = var.error_default_value
    unit           = var.error_metric_unit
  }
}

resource "aws_cloudwatch_log_metric_filter" "lambda_success_filter" {
  name           = "LambdaSuccessFilter"
  log_group_name = var.log_group_name
  pattern        = "Survey data saved successfully"

  metric_transformation {
    name           = var.success_metric_name
    namespace      = var.success_metric_namespace
    value          = var.success_metric_value
    default_value  = var.success_default_value
    unit           = var.success_metric_unit
  }
}

resource "aws_cloudwatch_metric_alarm" "lambda_error_alarm" {
  alarm_name          = "LambdaErrorAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = var.error_metric_name
  namespace           = var.error_metric_namespace
  period              = "300" # 5 minutes
  statistic           = "Sum"
  threshold           = "1"
  alarm_actions       = [var.lambda_error_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "lambda_success_alarm" {
  alarm_name          = "LambdaSuccessAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = var.success_metric_name
  namespace           = var.success_metric_namespace
  period              = "300" # 5 minutes
  statistic           = "Sum"
  threshold           = "1"
  alarm_actions       = [var.lambda_success_topic_arn]
}
