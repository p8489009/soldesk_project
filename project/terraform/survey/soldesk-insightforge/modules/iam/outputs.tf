output "cloudwatch_agent_role_arn" {
  value = aws_iam_role.cloudwatch_agent_role.arn
}


output "cloudwatch_agent_instance_profile_arn" {
  value = aws_iam_instance_profile.cloudwatch_agent_profile.arn
}


output "db_cloudwatch_agent_role_arn" {
  value = aws_iam_role.db_cloudwatch_agent_role.arn
}


output "db_cloudwatch_agent_instance_profile_arn" {
  value = aws_iam_instance_profile.db_cloudwatch_agent_profile.arn
}

output "mywebserver_role_arn" {
  value = aws_iam_role.mywebserver_role.arn
}

output "mywebserver_instance_profile_name" {
  value = aws_iam_instance_profile.mywebserver_instance_profile.name
}

output "glue_role_arn" {
  value = aws_iam_role.glue_role.arn
}