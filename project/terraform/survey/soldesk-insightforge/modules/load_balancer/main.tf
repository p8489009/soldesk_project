provider "aws" {
  region = var.region
}

resource "aws_lb" "nginx_alb" {
  name               = "VEC-PRD-NGINX-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.nginx_security_group]
  subnets            = [var.nginx_subnet_2a, var.nginx_subnet_2c]

  enable_deletion_protection = false

  tags = {
    Name = "VEC-PRD-NGINX-ALB"
  }
}

resource "aws_lb_listener" "nginx_http_listener" {
  load_balancer_arn = aws_lb.nginx_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.nginx_target_group_arn
  }
}

resource "aws_lb_listener" "nginx_https_listener" {
  load_balancer_arn = aws_lb.nginx_alb.arn
  port              = "443"
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.nginx_target_group_arn
  }
}

resource "aws_lb" "tomcat_alb" {
  name               = "VEC-PRD-TOMCAT-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.tomcat_security_group]
  subnets            = [var.tomcat_subnet_2a, var.tomcat_subnet_2c]

  enable_deletion_protection = false

  tags = {
    Name = "VEC-PRD-TOMCAT-ALB"
  }
}

resource "aws_lb_listener" "tomcat_http_listener" {
  load_balancer_arn = aws_lb.tomcat_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.tomcat_target_group_arn
  }
}

resource "aws_lb_listener" "tomcat_https_listener" {
  load_balancer_arn = aws_lb.tomcat_alb.arn
  port              = "443"
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.tomcat_target_group_arn
  }
}
