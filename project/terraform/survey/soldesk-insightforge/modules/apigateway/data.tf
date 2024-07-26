data "aws_api_gateway_domain_name" "custom_domain" {
  domain_name = aws_api_gateway_domain_name.custom_domain.domain_name
}