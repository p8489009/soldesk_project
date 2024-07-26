provider "aws" {
  region = var.region
}

resource "aws_sns_topic" "nginx_pub_2a" {
  name = "NGINX-PUB-2A-TerminateInstanceNotifications"
}

resource "aws_sns_topic" "nginx_pub_2c" {
  name = "NGINX-PUB-2C-TerminateInstanceNotifications"
}

resource "aws_sns_topic" "tomcat_pri_2a" {
  name = "TOMCAT-PRI-2A-TerminateInstanceNotifications"
}

resource "aws_sns_topic" "tomcat_pri_2c" {
  name = "TOMCAT-PRI-2C-TerminateInstanceNotifications"
}

resource "aws_sns_topic" "db_pri_2a" {
  name = "DB-PRI-2A-TerminateInstanceNotifications"
}

resource "aws_sns_topic" "db_pri_2c" {
  name = "DB-PRI-2C-TerminateInstanceNotifications"
}

resource "aws_sns_topic_subscription" "nginx_pub_2a" {
  topic_arn = aws_sns_topic.nginx_pub_2a.arn
  protocol  = "email"
  endpoint  = "p8489009@gmail.com"
}

resource "aws_sns_topic_subscription" "nginx_pub_2c" {
  topic_arn = aws_sns_topic.nginx_pub_2c.arn
  protocol  = "email"
  endpoint  = "p8489009@gmail.com"
}

resource "aws_sns_topic_subscription" "tomcat_pri_2a" {
  topic_arn = aws_sns_topic.tomcat_pri_2a.arn
  protocol  = "email"
  endpoint  = "p8489009@gmail.com"
}

resource "aws_sns_topic_subscription" "tomcat_pri_2c" {
  topic_arn = aws_sns_topic.tomcat_pri_2c.arn
  protocol  = "email"
  endpoint  = "p8489009@gmail.com"
}

resource "aws_sns_topic_subscription" "db_pri_2a" {
  topic_arn = aws_sns_topic.db_pri_2a.arn
  protocol  = "email"
  endpoint  = "p8489009@gmail.com"
}

resource "aws_sns_topic_subscription" "db_pri_2c" {
  topic_arn = aws_sns_topic.db_pri_2c.arn
  protocol  = "email"
  endpoint  = "p8489009@gmail.com"
}
