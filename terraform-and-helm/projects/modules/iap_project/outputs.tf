/* Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
*/

output "project_id" {
  value = "${module.service_project.project_id}"
}

output "project_number" {
  value = "${module.service_project.project_number}"
}

output "service_account_email" {
  value = "${module.service_project.service_account_email}"
}
