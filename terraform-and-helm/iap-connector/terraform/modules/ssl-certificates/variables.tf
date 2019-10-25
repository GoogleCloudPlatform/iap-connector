/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

variable "name_prefix" {
  description = "The name prefix for the certificate"
}

variable "certificate" {
  description = "The certificate for the application in PEM format"
}

variable "key" {
  description = "The key for the application certificate"
}

variable "project_id" {
  description = "The id for the project to host the certificate"
}
