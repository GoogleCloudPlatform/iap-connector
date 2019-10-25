/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

locals {
  env = "prod"
}

resource "google_service_account" "jenkins" {
  account_id   = "${local.jenkins_iap_sa_account_id}"
  display_name = "${local.jenkins_iap_sa_display_name}"
  project      = "${local.iam_mgmt_project_id}"
}
