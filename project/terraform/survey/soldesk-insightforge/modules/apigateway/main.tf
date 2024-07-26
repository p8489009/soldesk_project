resource "aws_api_gateway_rest_api" "rest_api" {
  name        = var.name
  description = var.description
}

# /survey 리소스
resource "aws_api_gateway_resource" "survey_resource" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = "survey"
}

# /survey/{surveyId+} 프록시 리소스
resource "aws_api_gateway_resource" "survey_id_proxy" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.survey_resource.id
  path_part   = "{surveyId+}"
}

# /submit 리소스
resource "aws_api_gateway_resource" "submit_resource" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = "submit"
}

# /submit/{surveyId+} 프록시 리소스
resource "aws_api_gateway_resource" "submit_id_proxy" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_resource.submit_resource.id
  path_part   = "{surveyId+}"
}

# /survey POST 메서드 및 통합
resource "aws_api_gateway_method" "post_survey_method" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.survey_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "post_survey_integration" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.survey_resource.id
  http_method             = aws_api_gateway_method.post_survey_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn_save_survey_data
  passthrough_behavior    = "WHEN_NO_MATCH"
}

resource "aws_api_gateway_method_response" "post_survey_method_response" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.survey_resource.id
  http_method = aws_api_gateway_method.post_survey_method.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "post_survey_integration_response" {
  depends_on = [ aws_api_gateway_integration.post_survey_integration ]
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.survey_resource.id
  http_method = aws_api_gateway_method.post_survey_method.http_method
  status_code = aws_api_gateway_method_response.post_survey_method_response.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

# /survey GET 메서드 및 통합
resource "aws_api_gateway_method" "get_survey_method" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.survey_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_survey_integration" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.survey_resource.id
  http_method             = aws_api_gateway_method.get_survey_method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = var.lambda_invoke_arn_get_survey
  passthrough_behavior    = "WHEN_NO_MATCH"
}

resource "aws_api_gateway_method_response" "get_survey_method_response" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.survey_resource.id
  http_method = aws_api_gateway_method.get_survey_method.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "get_survey_integration_response" {
  depends_on = [ aws_api_gateway_integration.get_survey_integration ]
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.survey_resource.id
  http_method = aws_api_gateway_method.get_survey_method.http_method
  status_code = aws_api_gateway_method_response.get_survey_method_response.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

# /survey/{surveyId+} GET 메서드 및 통합
resource "aws_api_gateway_method" "get_survey_id_method" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.survey_id_proxy.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_survey_id_integration" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.survey_id_proxy.id
  http_method             = aws_api_gateway_method.get_survey_id_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn_get_survey
  passthrough_behavior    = "WHEN_NO_MATCH"
}

resource "aws_api_gateway_method_response" "get_survey_id_method_response" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.survey_id_proxy.id
  http_method = aws_api_gateway_method.get_survey_id_method.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "get_survey_id_integration_response" {
  depends_on = [ aws_api_gateway_integration.get_survey_id_integration ]
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.survey_id_proxy.id
  http_method = aws_api_gateway_method.get_survey_id_method.http_method
  status_code = aws_api_gateway_method_response.get_survey_id_method_response.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

# /submit POST 메서드 및 통합
resource "aws_api_gateway_method" "post_submit_method" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.submit_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "post_submit_integration" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.submit_resource.id
  http_method             = aws_api_gateway_method.post_submit_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn_submit_survey_response
  passthrough_behavior    = "WHEN_NO_MATCH"
}

resource "aws_api_gateway_method_response" "post_submit_method_response" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.submit_resource.id
  http_method = aws_api_gateway_method.post_submit_method.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "post_submit_integration_response" {
  depends_on = [ aws_api_gateway_integration.post_submit_integration ]
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.submit_resource.id
  http_method = aws_api_gateway_method.post_submit_method.http_method
  status_code = aws_api_gateway_method_response.post_submit_method_response.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

# /submit/{surveyId+} GET 메서드 및 통합
resource "aws_api_gateway_method" "get_submit_id_method" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.submit_id_proxy.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_submit_id_integration" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.submit_id_proxy.id
  http_method             = aws_api_gateway_method.get_submit_id_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn_view_survey
  passthrough_behavior    = "WHEN_NO_MATCH"
}

resource "aws_api_gateway_method_response" "get_submit_id_method_response" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.submit_id_proxy.id
  http_method = aws_api_gateway_method.get_submit_id_method.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "get_submit_id_integration_response" {
  depends_on = [ aws_api_gateway_integration.get_submit_id_integration ]
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.submit_id_proxy.id
  http_method = aws_api_gateway_method.get_submit_id_method.http_method
  status_code = aws_api_gateway_method_response.get_submit_id_method_response.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

# CORS 설정을 위한 OPTIONS 메서드 (모든 리소스에 대해)
resource "aws_api_gateway_method" "options_method_survey" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.survey_resource.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "options_integration_survey" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.survey_resource.id
  http_method             = aws_api_gateway_method.options_method_survey.http_method
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "options_method_response_survey" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.survey_resource.id
  http_method = aws_api_gateway_method.options_method_survey.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "options_integration_response_survey" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.survey_resource.id
  http_method = aws_api_gateway_method.options_method_survey.http_method
  status_code = aws_api_gateway_method_response.options_method_response_survey.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,POST,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
}

resource "aws_api_gateway_method" "options_method_survey_id" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.survey_id_proxy.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "options_integration_survey_id" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.survey_id_proxy.id
  http_method             = aws_api_gateway_method.options_method_survey_id.http_method
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "options_method_response_survey_id" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.survey_id_proxy.id
  http_method = aws_api_gateway_method.options_method_survey_id.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "options_integration_response_survey_id" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.survey_id_proxy.id
  http_method = aws_api_gateway_method.options_method_survey_id.http_method
  status_code = aws_api_gateway_method_response.options_method_response_survey_id.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,POST,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
}

resource "aws_api_gateway_method" "options_method_submit" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.submit_resource.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "options_integration_submit" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.submit_resource.id
  http_method             = aws_api_gateway_method.options_method_submit.http_method
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "options_method_response_submit" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.submit_resource.id
  http_method = aws_api_gateway_method.options_method_submit.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "options_integration_response_submit" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.submit_resource.id
  http_method = aws_api_gateway_method.options_method_submit.http_method
  status_code = aws_api_gateway_method_response.options_method_response_submit.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,POST,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
}

resource "aws_api_gateway_method" "options_method_submit_id" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.submit_id_proxy.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "options_integration_submit_id" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.submit_id_proxy.id
  http_method             = aws_api_gateway_method.options_method_submit_id.http_method
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "options_method_response_submit_id" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.submit_id_proxy.id
  http_method = aws_api_gateway_method.options_method_submit_id.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "options_integration_response_submit_id" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.submit_id_proxy.id
  http_method = aws_api_gateway_method.options_method_submit_id.http_method
  status_code = aws_api_gateway_method_response.options_method_response_submit_id.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,POST,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.post_survey_integration,
    aws_api_gateway_integration.get_survey_integration,
    aws_api_gateway_integration.get_survey_id_integration,
    aws_api_gateway_integration.post_submit_integration,
    aws_api_gateway_integration.get_submit_id_integration,
    aws_api_gateway_integration.options_integration_survey,
    aws_api_gateway_integration_response.options_integration_response_survey,
    aws_api_gateway_integration.options_integration_survey_id,
    aws_api_gateway_integration_response.options_integration_response_survey_id,
    aws_api_gateway_integration.options_integration_submit,
    aws_api_gateway_integration_response.options_integration_response_submit,
    aws_api_gateway_integration.options_integration_submit_id,
    aws_api_gateway_integration_response.options_integration_response_submit_id,
  ]
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  stage_name  = var.stage_name
}

resource "aws_api_gateway_method_settings" "method_settings" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  stage_name  = aws_api_gateway_deployment.api_deployment.stage_name

  method_path = "*/*"
  settings {
    metrics_enabled     = true
    logging_level       = "INFO"
    data_trace_enabled  = true
  }
}

output "api_endpoint" {
  value = aws_api_gateway_deployment.api_deployment.invoke_url
}


resource "aws_api_gateway_domain_name" "custom_domain" {
  domain_name     = var.custom_domain_name
  regional_certificate_arn = var.certificate_arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_base_path_mapping" "path_mapping" {
  depends_on = [ aws_api_gateway_method_settings.method_settings ]
  domain_name = aws_api_gateway_domain_name.custom_domain.domain_name
  api_id = aws_api_gateway_rest_api.rest_api.id
  stage_name  = var.stage_name
}
