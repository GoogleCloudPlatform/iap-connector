/* Copyright 2019 Google LLC. This software is provided as is, without warranty
 * or representation for any use or purpose. Your use of it is subject to your
 * agreement with Google.
*/

variable "project_name" {
  description = "The name of the project"
}

variable "project_id" {
  description = "The id for the project"
}

variable "billing_account_id" {
  description = "The billing account id to link the project to"
}

variable "folder_id" {
  description = "The folder id in which to place the project"
}

variable "create_default_network" {
  default     = "fales"
  description = "Boolean on whether to create the default network"
}

variable "services" {
  description = "The services (Google APIs) to enable for the project"
  type        = "list"
}
