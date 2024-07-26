output "nginx_pub_2a_arn" {
  value = aws_sns_topic.nginx_pub_2a.arn
}

output "nginx_pub_2c_arn" {
  value = aws_sns_topic.nginx_pub_2c.arn
}

output "tomcat_pri_2a_arn" {
  value = aws_sns_topic.tomcat_pri_2a.arn
}

output "tomcat_pri_2c_arn" {
  value = aws_sns_topic.tomcat_pri_2c.arn
}

output "db_pri_2a_arn" {
  value = aws_sns_topic.db_pri_2a.arn
}

output "db_pri_2c_arn" {
  value = aws_sns_topic.db_pri_2c.arn
}
