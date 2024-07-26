provider "aws" {
  region = var.region
}

# DynamoDB 모듈
module "dynamodb_surveys" {
  source      = "./modules/dynamodb"
  surveys_table_name = var.surveys_table_name
  survey_responses_table_name = var.survey_responses_table_name
  environment = "Production"
}

# IAM 모듈
module "iam" {
  source             = "./modules/iam"
  lambda_role_name   = "lambda-dynamodb-role"
  api_gateway_role_name = "apigateway-cloudwatch-role"
}

# Lambda 모듈들
module "lambda_save_survey_data" {
  source        = "./modules/lambda"
  s3_bucket     = var.s3_bucket_name
  s3_key        = "SaveSurveyData.zip"
  function_name = "SaveSurveyData"
  role_arn      = module.iam.lambda_dynamodb_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"
  dynamodb_table = module.dynamodb_surveys.surveys_table_name
  source_arn    = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:*"
}

module "lambda_get_survey" {
  source        = "./modules/lambda"
  s3_bucket     = var.s3_bucket_name
  s3_key        = "GetSurvey.zip"
  function_name = "GetSurvey"
  role_arn      = module.iam.lambda_dynamodb_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"
  dynamodb_table = module.dynamodb_surveys.surveys_table_name
  source_arn    = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:*"
}

module "lambda_submit_survey_response" {
  source        = "./modules/lambda"
  s3_bucket     = var.s3_bucket_name
  s3_key        = "SubmitSurveyResponse.zip"
  function_name = "SubmitSurveyResponse"
  role_arn      = module.iam.lambda_dynamodb_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"
  dynamodb_table = module.dynamodb_surveys.survey_responses_table_name
  source_arn    = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:*"
}

module "lambda_view_survey" {
  source        = "./modules/lambda"
  s3_bucket     = var.s3_bucket_name
  s3_key        = "ViewSurvey.zip"
  function_name = "ViewSurvey"
  role_arn      = module.iam.lambda_dynamodb_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"
  dynamodb_table = module.dynamodb_surveys.surveys_table_name
  source_arn    = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:*"
}
module "lambda_Surveys_items" {
  source        = "./modules/lambda"
  s3_bucket     = var.s3_bucket_name
  s3_key        = "Surveys-items.zip"
  function_name = "Surveys-items"
  role_arn      = module.iam.lambda_dynamodb_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"
  dynamodb_table = module.dynamodb_surveys.surveys_table_name
  source_arn    = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:*"
}
module "lambda_SurveyResponses_items" {
  source        = "./modules/lambda"
  s3_bucket     = var.s3_bucket_name
  s3_key        = "SurveyResponses-items.zip"
  function_name = "SurveyResponses-items"
  role_arn      = module.iam.lambda_dynamodb_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"
  dynamodb_table = module.dynamodb_surveys.surveys_table_name
  source_arn    = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:*"
}
# API Gateway
module "apigateway" {
  source               = "./modules/apigateway"
  name                 = var.api_gateway_name
  description          = var.api_gateway_description
  stage_name           = var.api_gateway_stage_name
  lambda_invoke_arn_save_survey_data = module.lambda_save_survey_data.lambda_invoke_arn
  lambda_invoke_arn_get_survey = module.lambda_get_survey.lambda_invoke_arn
  lambda_invoke_arn_submit_survey_response = module.lambda_submit_survey_response.lambda_invoke_arn
  lambda_invoke_arn_view_survey = module.lambda_view_survey.lambda_invoke_arn
  certificate_arn = var.certificate_arn_api
  custom_domain_name = var.custom_domain_name
}

module "route53" {
  source = "./modules/route53"
  region       = var.region
  alb_dns_name = module.load_balancer.nginx_alb_dns_name
  alb_under_zone_id  = module.load_balancer.nginx_alb_zone_id
  api_dns_name = module.apigateway.api_domain_name
  api_under_zone_id  = module.apigateway.api_zone_id
  cloudfront_zone_id = var.cloudfront_zone_id
  cloudfront_dns_name = module.cloudfront.cloudfront_distribution_domain_name
  cloudfront_zone_id_id = module.cloudfront.cloudfront_distribution_hosted_zone_id
}

module "cloudfront" {
  source = "./modules/cloudfront"
  cloudfront_certificate= var.cloudfront_certificate
}

module "cloudwatch_metric_filters" {
  source                 = "./modules/CloudWatch"
  log_group_name         = "/aws/lambda/SaveSurveyData"
  
  error_metric_name      = "ErrorCount"
  error_metric_namespace = "MyApp/LambdaErrors"
  error_metric_value     = "1"
  error_default_value    = 0
  error_metric_unit      = "Count"
  
  success_metric_name      = "SuccessCount"
  success_metric_namespace = "MyApp/LambdaSuccesses"
  success_metric_value     = "1"
  success_default_value    = 0
  success_metric_unit      = "Count"
  lambda_error_topic_arn   = module.sns_notifications.lambda_error_topic_arn
  lambda_success_topic_arn = module.sns_notifications.lambda_success_topic_arn
}

module "sns_notifications" {
  source = "./modules/SNS"
}

module "vpc" {
  source = "./modules/VPC"

  # 필요한 변수들을 여기에 추가합니다
}

module "target_group" {
  source = "./modules/target_group"

  region = var.region
  vpc_id = module.vpc.vpc_id # VPC 모듈에서 생성된 VPC ID를 참조합니다.
}

module "load_balancer" {
  source = "./modules/load_balancer"

  region = var.region

  nginx_subnet_2a        = module.vpc.public_subnets[1]
  nginx_subnet_2c        = module.vpc.public_subnets[2]
  nginx_security_group   = module.vpc.nginx_security_group
  nginx_target_group_arn = module.target_group.nginx_target_group_arn

  tomcat_subnet_2a        = module.vpc.private_subnets[0]
  tomcat_subnet_2c        = module.vpc.private_subnets[2]
  tomcat_security_group   = module.vpc.tomcat_security_group
  tomcat_target_group_arn = module.target_group.tomcat_target_group_arn

  acm_certificate_arn     = var.certificate_arn_api
}




module "launch_template" {
  source = "./modules/launch_template"

  region               = var.region
  ami_id               = "ami-0b10f98758e41769a" # 원하는 AMI ID로 변경
  key_name             = "soldesk.pem"
  nginx_pub_2a_subnet  = module.vpc.public_subnets[1]
  nginx_pub_2c_subnet  = module.vpc.public_subnets[2]
  tomcat_pri_2a_subnet = module.vpc.private_subnets[0]
  tomcat_pri_2c_subnet = module.vpc.private_subnets[2]
  db_pri_2a_subnet     = module.vpc.private_subnets[1]
  db_pri_2c_subnet     = module.vpc.private_subnets[3]
  nginx_security_group = module.vpc.nginx_security_group
  tomcat_security_group = module.vpc.tomcat_security_group
  db_security_group    = module.vpc.db_security_group

  asg_iam_instance_profile_arn = module.iam.cloudwatch_agent_instance_profile_arn
  db_asg_iam_instance_profile_arn = module.iam.db_cloudwatch_agent_instance_profile_arn
}

module "autoscaling" {
  source = "./modules/autoscaling"

  region                      = var.region
  nginx_pub_2a_launch_template_id  = module.launch_template.nginx_pub_2a_id
  nginx_pub_2c_launch_template_id  = module.launch_template.nginx_pub_2c_id
  tomcat_pri_2a_launch_template_id = module.launch_template.tomcat_pri_2a_id
  tomcat_pri_2c_launch_template_id = module.launch_template.tomcat_pri_2c_id
  db_pri_2a_launch_template_id     = module.launch_template.db_pri_2a_id
  db_pri_2c_launch_template_id     = module.launch_template.db_pri_2c_id
  nginx_pub_2a_subnet              = module.vpc.public_subnets[1]
  nginx_pub_2c_subnet              = module.vpc.public_subnets[2]
  tomcat_pri_2a_subnet             = module.vpc.private_subnets[0]
  tomcat_pri_2c_subnet             = module.vpc.private_subnets[2]
  db_pri_2a_subnet                 = module.vpc.private_subnets[1]
  db_pri_2c_subnet                 = module.vpc.private_subnets[3]
  nginx_target_group_arn           = module.target_group.nginx_target_group_arn
  tomcat_target_group_arn          = module.target_group.tomcat_target_group_arn
}


module "notifications" {
  source = "./modules/notifications"
  region = var.region
}


module "cloudwatch_alarms" {
  source = "./modules/cloudwatch_alarms"
  region = var.region


  nginx_pub_2a_arn  = module.notifications.nginx_pub_2a_arn
  nginx_pub_2c_arn  = module.notifications.nginx_pub_2c_arn
  tomcat_pri_2a_arn = module.notifications.tomcat_pri_2a_arn
  tomcat_pri_2c_arn = module.notifications.tomcat_pri_2c_arn
  db_pri_2a_arn     = module.notifications.db_pri_2a_arn
  db_pri_2c_arn     = module.notifications.db_pri_2c_arn
}

module "waf" {
  source = "./modules/waf"

  region               = var.region
  nginx_alb_arn        = module.load_balancer.nginx_alb_arn
  tomcat_alb_arn       = module.load_balancer.tomcat_alb_arn 
}


module "s3" {
  source = "./modules/s3"
  region = var.region

}

module "waf_logging" {
  source = "./modules/waf_logging"
  region = var.region

  nginx_s3_bucket_arn = module.s3.waf_logs_nginx_bucket_arn
  tomcat_s3_bucket_arn = module.s3.waf_logs_tomcat_bucket_arn
  nginx_web_acl_arn = module.waf.nginx_web_acl_arn
  tomcat_web_acl_arn = module.waf.tomcat_web_acl_arn
}


module "ec2" {
  source = "./modules/EC2"
  region = var.region

  key_name = "soldesk.pem"
  subnet_id = module.vpc.subnet_id
  security_group_id = module.vpc.security_group_id
  instance_name = "EC2-mywebserver-deploy"
  mywebserver_iam_instance_profile_name = module.iam.mywebserver_instance_profile_name
}

module "cloudwatch_alarms_Surveys" {
  source = "./modules/cloudwatchlambda"
  lambda_function_name = "Surveys-items"
  lambda_function_arn = module.lambda_Surveys_items.lambda_function_arn
  name= "dynamodb_Surveys_items"
}
module "cloudwatch_alarms_SurveyResponses" {
  source = "./modules/cloudwatchlambda"
  lambda_function_name = "SurveyResponses-items"
  lambda_function_arn = module.lambda_SurveyResponses_items.lambda_function_arn
  name= "dynamodb_SurveyResponses_items"
}

module "resource_group" {
  source = "./modules/resource_group"
  region = var.region

  resource_group_name        = "EC2-mywebserver-deploy"
  resource_group_description = "Resource group for EC2 instances with specific tags"
  tag_key                    = "Name"
  tag_value                  = "EC2-mywebserver-deploy"
  
}

module "glue" {
  source = "./modules/glue"
  
  region = var.region
  glue_role_arn = module.iam.glue_role_arn

}

