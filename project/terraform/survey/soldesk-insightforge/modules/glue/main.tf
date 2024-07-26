resource "aws_glue_catalog_database" "dynamodb_surveys_db" {
  name = "dynamodb_surveys_db"
}

resource "aws_glue_catalog_database" "dynamodb_surveyresponses_db" {
  name = "dynamodb_surveyresponses_db"
}

resource "aws_glue_catalog_database" "nginx_db" {
  name = "aws-waf-logs-nginx-db"
}

resource "aws_glue_catalog_database" "tomcat_db" {
  name = "aws-waf-logs-tomcat-db"
}

resource "aws_glue_crawler" "dynamodb_surveys_crawler" {
  name          = "dynamodb-surveys-crawler"
  role          = var.glue_role_arn
  database_name = aws_glue_catalog_database.dynamodb_surveys_db.name
  table_prefix  = "item_"

  s3_target {
    path = "s3://aws-dynamodb-surveys-item"
  }

  schedule = "cron(0 0 * * ? *)"  # 매일 자정에 실행

  schema_change_policy {
    delete_behavior = "DEPRECATE_IN_DATABASE"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  configuration = jsonencode({
    Version = 1.0,
    CrawlerOutput = {
      Partitions = {
        AddOrUpdateBehavior = "InheritFromTable"
      }
    }
  })
}

resource "aws_glue_crawler" "dynamodb_surveyresponses_crawler" {
  name          = "dynamodb-surveyresponses-crawler"
  role          = var.glue_role_arn
  database_name = aws_glue_catalog_database.dynamodb_surveyresponses_db.name
  table_prefix  = "item_"

  s3_target {
    path = "s3://aws-dynamodb-surveyresponses-item"
  }

  schedule = "cron(0 0 * * ? *)"  # 매일 자정에 실행

  schema_change_policy {
    delete_behavior = "DEPRECATE_IN_DATABASE"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  configuration = jsonencode({
    Version = 1.0,
    CrawlerOutput = {
      Partitions = {
        AddOrUpdateBehavior = "InheritFromTable"
      }
    }
  })
}


resource "aws_glue_crawler" "nginx_crawler" {
  name          = "aws-waf-logs-nginx-crawler"
  role          = var.glue_role_arn
  database_name = aws_glue_catalog_database.nginx_db.name
  table_prefix  = "nginx_"

  s3_target {
    path = "s3://aws-waf-logs-nginx"
  }

  schedule = "cron(0 0 * * ? *)"  # 매일 자정에 실행

  schema_change_policy {
    delete_behavior = "DEPRECATE_IN_DATABASE"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  configuration = jsonencode({
    Version = 1.0,
    CrawlerOutput = {
      Partitions = {
        AddOrUpdateBehavior = "InheritFromTable"
      }
    }
  })
}

resource "aws_glue_crawler" "tomcat_crawler" {
  name          = "aws-waf-logs-tomcat-crawler"
  role          = var.glue_role_arn
  database_name = aws_glue_catalog_database.tomcat_db.name
  table_prefix  = "tomcat_"

  s3_target {
    path = "s3://aws-waf-logs-tomcat"
  }

  schedule = "cron(0 0 * * ? *)"  # 매일 자정에 실행

  schema_change_policy {
    delete_behavior = "DEPRECATE_IN_DATABASE"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  configuration = jsonencode({
    Version = 1.0,
    CrawlerOutput = {
      Partitions = {
        AddOrUpdateBehavior = "InheritFromTable"
      }
    }
  })
}