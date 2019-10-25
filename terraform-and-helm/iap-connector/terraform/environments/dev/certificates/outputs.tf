/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

output "confluence_ssl_id" {
  value = "${module.ssl_certificate_confluence.certificate_id}"
}

output "confluence_ssl_name" {
  value = "${module.ssl_certificate_confluence.certificate_name}"
}

output "jira_ssl_id" {
  value = "${module.ssl_certificate_jira.certificate_id}"
}

output "jira_ssl_name" {
  value = "${module.ssl_certificate_jira.certificate_name}"
}
