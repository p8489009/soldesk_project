output "waf_logs_nginx_bucket_arn" {
  value = aws_s3_bucket.waf_logs_nginx.arn
}

output "waf_logs_tomcat_bucket_arn" {
  value = aws_s3_bucket.waf_logs_tomcat.arn
}
