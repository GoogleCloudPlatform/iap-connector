/* Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
*/

variable "app" {
  description = "The name of the application"
}

# Defaults to org id for airbedandbreakfast.com
variable "org_id" {
  default     = "353996489736"
  description = "The Google organization id in which to place the projects"
}

variable "billing_account_id" {
  description = "The id for the billing account to link to the project"
}

variable "host_vpc_project" {
  description = "Shared VPC Host project"
}

variable "env" {
  default     = "dev"
  description = "The environment that this template will create"
}

variable "folder_id" {
  description = "The id for the folder in which to place the project"
}

variable "subnet_ids" {
  type        = "list"
  description = "The list of subnet ids to attach to in the host vpc project. The subnets should have the format 'projects/<host_vpc_project>/regions/<subnet_region>/subnetworks/<subnet_name>'"
}

variable "default_service_account" {
  default     = "keep"
  description = "Project default service account setting: (delete | depriviledge | keep)"
}

variable "activate_apis" {
  type        = "list"
  description = "The services aka apis to enable for the project"
}
