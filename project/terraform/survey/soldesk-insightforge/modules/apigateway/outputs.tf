output "rest_api_id" {
  value = aws_api_gateway_rest_api.rest_api.id
}
output "api_domain_name" {
  value = data.aws_api_gateway_domain_name.custom_domain.regional_domain_name
}


output "api_zone_id" {
  value = data.aws_api_gateway_domain_name.custom_domain.regional_zone_id
}

