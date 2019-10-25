/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

variable "confluence_certificate" {
  description = "The certificate for Confluence in PEM format"
}

variable "confluence_key" {
  description = "The key for the Confluence certificate"
}

variable "jira_certificate" {
  description = "The certificate for JIRA in PEM format"
}

variable "jira_key" {
  description = "The key for the JIRA certificate"
}
