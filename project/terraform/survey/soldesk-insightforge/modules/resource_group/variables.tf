variable "region" {
  description = "The region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "resource_group_description" {
  description = "The description of the resource group"
  type        = string
}

variable "tag_key" {
  description = "The key for tagging EC2 instances"
  type        = string
}

variable "tag_value" {
  description = "The value for tagging EC2 instances"
  type        = string
}
