/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

locals {
  env = "management" # this isn't used but it's needed for locals in shared.tf
}

resource "google_service_account" "logicmonitor" {
  account_id   = ""
  display_name = "LogicMonitor service account"
  project      = "${local.iam_mgmt_project_id}"
}
