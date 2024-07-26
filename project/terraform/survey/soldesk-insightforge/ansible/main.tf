provider "aws" {
  region = var.region
}

module "ssm_runcommand" {
  source = "../modules/ssm_runcommand"
  region = var.region

  resource_group_name = "EC2-mywebserver-deploy"
  tag_value           = "EC2-mywebserver-deploy"
  
}