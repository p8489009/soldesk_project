provider "aws" {
  region = var.region
}

resource "aws_wafv2_web_acl" "nginx_web_acl" {
  name        = "NGINX-WebACL"
  scope       = "REGIONAL"
  description = "NGINX Web ACL"
  default_action {
    allow {}
  }
  visibility_config {
    sampled_requests_enabled = true
    cloudwatch_metrics_enabled = true
    metric_name = "nginxWebACL"
  }
  rule {
    name     = "AWSManagedRulesSQLiRuleSet"
    priority = 1
    override_action {
      count {}
    }
    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesSQLiRuleSet"
      }
    }
    visibility_config {
      sampled_requests_enabled = true
      cloudwatch_metrics_enabled = true
      metric_name = "AWSManagedRulesSQLiRuleSet"
    }
  }
  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 2
    override_action {
      count {}
    }
    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesCommonRuleSet"
      }
    }
    visibility_config {
      sampled_requests_enabled = true
      cloudwatch_metrics_enabled = true
      metric_name = "AWSManagedRulesCommonRuleSet"
    }
  }
}

resource "aws_wafv2_web_acl_association" "nginx" {
  resource_arn = var.nginx_alb_arn
  web_acl_arn  = aws_wafv2_web_acl.nginx_web_acl.arn
}

resource "aws_wafv2_web_acl" "tomcat_web_acl" {
  name        = "TOMCAT-WebACL"
  scope       = "REGIONAL"
  description = "TOMCAT Web ACL"
  default_action {
    allow {}
  }
  visibility_config {
    sampled_requests_enabled = true
    cloudwatch_metrics_enabled = true
    metric_name = "tomcatWebACL"
  }
  rule {
    name     = "AWSManagedRulesSQLiRuleSet"
    priority = 1
    override_action {
      count {}
    }
    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesSQLiRuleSet"
      }
    }
    visibility_config {
      sampled_requests_enabled = true
      cloudwatch_metrics_enabled = true
      metric_name = "AWSManagedRulesSQLiRuleSet"
    }
  }
  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 2
    override_action {
      count {}
    }
    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesCommonRuleSet"
      }
    }
    visibility_config {
      sampled_requests_enabled = true
      cloudwatch_metrics_enabled = true
      metric_name = "AWSManagedRulesCommonRuleSet"
    }
  }
}

resource "aws_wafv2_web_acl_association" "tomcat" {
  resource_arn = var.tomcat_alb_arn
  web_acl_arn  = aws_wafv2_web_acl.tomcat_web_acl.arn
}


