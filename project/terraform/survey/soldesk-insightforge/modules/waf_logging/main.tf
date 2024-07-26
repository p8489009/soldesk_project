resource "aws_wafv2_web_acl_logging_configuration" "nginx_logging" {
  log_destination_configs = [var.nginx_s3_bucket_arn]
  resource_arn            = var.nginx_web_acl_arn
}

resource "aws_wafv2_web_acl_logging_configuration" "tomcat_logging" {
  log_destination_configs = [var.tomcat_s3_bucket_arn]
  resource_arn            = var.tomcat_web_acl_arn
}
