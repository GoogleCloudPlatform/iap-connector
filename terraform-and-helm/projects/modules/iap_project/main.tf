/* Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
*/

# Need to use v2.4.1 of the project factory since it is the last version that
# supports terraform 0.11.x
module "service_project" {
  source                  = "github.com/terraform-google-modules/terraform-google-project-factory.git?ref=v2.4.1"
  random_project_id       = true
  name                    = "${var.app}-${var.env}"
  org_id                  = "${var.org_id}"
  folder_id               = "${var.folder_id}"
  billing_account         = "${var.billing_account_id}"
  shared_vpc              = "${var.host_vpc_project}"
  activate_apis           = "${var.activate_apis}"
  shared_vpc_subnets      = "${var.subnet_ids}"
  default_service_account = "${var.default_service_account}"
}

# Enable IAP audit logs for the project
resource "google_project_iam_audit_config" "main" {
  project = "${module.service_project.project_id}"
  service = "iap.googleapis.com"

  audit_log_config {
    log_type = "ADMIN_READ"
  }

  audit_log_config {
    log_type = "DATA_READ"
  }

  audit_log_config {
    log_type = "DATA_WRITE"
  }
}
