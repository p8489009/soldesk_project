output "nginx_web_acl_arn" {
  value = aws_wafv2_web_acl.nginx_web_acl.arn
}

output "tomcat_web_acl_arn" {
  value = aws_wafv2_web_acl.tomcat_web_acl.arn
}
