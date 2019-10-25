/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

locals {
  iap_folder_id = ""
}

resource "google_folder_iam_member" "logicmonitor" {
  folder = "folders/${local.iap_folder_id}"
  role   = "roles/viewer"
  member = ""
}
