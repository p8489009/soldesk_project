resource "aws_resourcegroups_group" "ec2_mywebserver_deploy" {
  name        = var.resource_group_name
  description = var.resource_group_description

  resource_query {
    query = jsonencode({
      ResourceTypeFilters = ["AWS::EC2::Instance"],
      TagFilters = [
        {
          Key    = var.tag_key,
          Values = [var.tag_value]
        }
      ]
    })
  }
}
