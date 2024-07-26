provider "aws" {
  region = var.region
}

resource "aws_route53_record" "www_record" {
  zone_id = var.cloudfront_zone_id
  name    = "survey.soldesk-insightforge.site"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_under_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "api_record" {
  zone_id = var.cloudfront_zone_id
  name    = "api.soldesk-insightforge.site"
  type    = "A"

  alias {
    name                   = var.api_dns_name
    zone_id                = var.api_under_zone_id
    evaluate_target_health = true
  }
}
resource "aws_route53_record" "www" {
  zone_id = var.cloudfront_zone_id # 호스팅 영역 ID
  name    = "www.soldesk-insightforge.site"      # 도메인 이름
  type    = "A"

  alias {
    name                   = var.cloudfront_dns_name
    zone_id                = var.cloudfront_zone_id_id
    evaluate_target_health = false
  }
}
