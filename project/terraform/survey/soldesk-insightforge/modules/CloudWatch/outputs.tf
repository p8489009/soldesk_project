output "error_metric_filter_id" {
  value = aws_cloudwatch_log_metric_filter.lambda_error_filter.id
}

output "success_metric_filter_id" {
  value = aws_cloudwatch_log_metric_filter.lambda_success_filter.id
}
