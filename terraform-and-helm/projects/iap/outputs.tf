/* Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
*/

output "project_id_dev" {
  value = "${module.iap_dev.project_id}"
}

output "project_number_dev" {
  value = "${module.iap_dev.project_number}"
}

output "project_id_stage" {
  value = "${module.iap_stage.project_id}"
}

output "project_number_stage" {
  value = "${module.iap_stage.project_number}"
}

output "project_id_prod" {
  value = "${module.iap_prod.project_id}"
}

output "project_number_prod" {
  value = "${module.iap_prod.project_number}"
}
