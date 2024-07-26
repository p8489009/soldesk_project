variable "nginx_pub_2a_arn" {
  description = "ARN for NGINX-PUB-2A notifications"
  type        = string
}

variable "nginx_pub_2c_arn" {
  description = "ARN for NGINX-PUB-2C notifications"
  type        = string
}

variable "tomcat_pri_2a_arn" {
  description = "ARN for TOMCAT-PRI-2A notifications"
  type        = string
}

variable "tomcat_pri_2c_arn" {
  description = "ARN for TOMCAT-PRI-2C notifications"
  type        = string
}

variable "db_pri_2a_arn" {
  description = "ARN for DB-PRI-2A notifications"
  type        = string
}

variable "db_pri_2c_arn" {
  description = "ARN for DB-PRI-2C notifications"
  type        = string
}

resource "aws_cloudwatch_metric_alarm" "NGINX-PUB-2A-TerminateInstanceAlarm" {
  alarm_name          = "NGINX-PUB-2A-TerminateInstanceAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "GroupTerminatingInstances"
  namespace           = "AWS/AutoScaling"
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "This metric monitors the terminating instances in NGINX-PUB-2A"
  actions_enabled     = true
  alarm_actions       = [var.nginx_pub_2a_arn]
  dimensions = {
    AutoScalingGroupName = "VEC-PRD-VPC-NGINX-PUB-2A"
  }
}

resource "aws_cloudwatch_metric_alarm" "NGINX-PUB-2C-TerminateInstanceAlarm" {
  alarm_name          = "NGINX-PUB-2C-TerminateInstanceAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "GroupTerminatingInstances"
  namespace           = "AWS/AutoScaling"
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "This metric monitors the terminating instances in NGINX-PUB-2C"
  actions_enabled     = true
  alarm_actions       = [var.nginx_pub_2c_arn]
  dimensions = {
    AutoScalingGroupName = "VEC-PRD-VPC-NGINX-PUB-2C"
  }
}

resource "aws_cloudwatch_metric_alarm" "TOMCAT-PRI-2A-TerminateInstanceAlarm" {
  alarm_name          = "TOMCAT-PRI-2A-TerminateInstanceAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "GroupTerminatingInstances"
  namespace           = "AWS/AutoScaling"
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "This metric monitors the terminating instances in TOMCAT-PRI-2A"
  actions_enabled     = true
  alarm_actions       = [var.tomcat_pri_2a_arn]
  dimensions = {
    AutoScalingGroupName = "VEC-PRD-VPC-TOMCAT-PRI-2A"
  }
}

resource "aws_cloudwatch_metric_alarm" "TOMCAT-PRI-2C-TerminateInstanceAlarm" {
  alarm_name          = "TOMCAT-PRI-2C-TerminateInstanceAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "GroupTerminatingInstances"
  namespace           = "AWS/AutoScaling"
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "This metric monitors the terminating instances in TOMCAT-PRI-2C"
  actions_enabled     = true
  alarm_actions       = [var.tomcat_pri_2c_arn]
  dimensions = {
    AutoScalingGroupName = "VEC-PRD-VPC-TOMCAT-PRI-2C"
  }
}

resource "aws_cloudwatch_metric_alarm" "DB-PRI-2A-TerminateInstanceAlarm" {
  alarm_name          = "DB-PRI-2A-TerminateInstanceAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "GroupTerminatingInstances"
  namespace           = "AWS/AutoScaling"
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "This metric monitors the terminating instances in DB-PRI-2A"
  actions_enabled     = true
  alarm_actions       = [var.db_pri_2a_arn]
  dimensions = {
    AutoScalingGroupName = "VEC-PRD-VPC-DB-PRI-2A"
  }
}

resource "aws_cloudwatch_metric_alarm" "DB-PRI-2C-TerminateInstanceAlarm" {
  alarm_name          = "DB-PRI-2C-TerminateInstanceAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "GroupTerminatingInstances"
  namespace           = "AWS/AutoScaling"
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "This metric monitors the terminating instances in DB-PRI-2C"
  actions_enabled     = true
  alarm_actions       = [var.db_pri_2c_arn]
  dimensions = {
    AutoScalingGroupName = "VEC-PRD-VPC-DB-PRI-2C"
  }
}
