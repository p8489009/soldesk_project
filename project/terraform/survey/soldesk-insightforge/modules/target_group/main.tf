provider "aws" {
  region = var.region
}

resource "aws_lb_target_group" "nginx_target_group" {
  name     = "VEC-PRD-NGINX-GROUP"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }

  target_type = "instance"
}

resource "aws_lb_target_group" "tomcat_target_group" {
  name     = "VEC-PRD-TOMCAT-GROUP"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }

  target_type = "instance"
}

output "nginx_target_group_arn" {
  value = aws_lb_target_group.nginx_target_group.arn
}

output "tomcat_target_group_arn" {
  value = aws_lb_target_group.tomcat_target_group.arn
}
