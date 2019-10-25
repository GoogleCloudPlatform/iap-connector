/* Copyright 2019 Google LLC. This software is provided as is, without warranty
 * or representation for any use or purpose. Your use of it is subject to your
 * agreement with Google.
*/

output "iam_management_project_id" {
  value = "${module.iam_management_project.project_id}"
}

output "iam_management_project_number" {
  value = "${module.iam_management_project.project_number}"
}

output "iap_host_project_id" {
  value = "${module.iap_host.project_id}"
}

output "iap_host_project_number" {
  value = "${module.iap_host.project_number}"
}
