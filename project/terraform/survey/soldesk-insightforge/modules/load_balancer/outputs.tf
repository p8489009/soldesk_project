output "nginx_alb_dns_name" {
  description = "The DNS name of the NGINX ALB"
  value       = aws_lb.nginx_alb.dns_name
}

output "nginx_alb_zone_id" {
  description = "The zone ID of the NGINX ALB"
  value       = aws_lb.nginx_alb.zone_id
}

output "tomcat_alb_dns_name" {
  description = "The DNS name of the Tomcat ALB"
  value       = aws_lb.tomcat_alb.dns_name
}

output "tomcat_alb_zone_id" {
  description = "The Zone ID of the Tomcat ALB"
  value       = aws_lb.tomcat_alb.zone_id
}


output "nginx_alb_arn" {
  description = "The ARN of the NGINX ALB"
  value       = aws_lb.nginx_alb.arn
}

output "tomcat_alb_arn" {
  description = "The ARN of the Tomcat ALB"
  value       = aws_lb.tomcat_alb.arn
}
