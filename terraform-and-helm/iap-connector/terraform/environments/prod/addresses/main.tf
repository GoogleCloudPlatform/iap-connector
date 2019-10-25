/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

locals {
  env = "prod"
}

resource "google_compute_global_address" "iap_atlsn_lb" {
  name        = ""
  description = ""
  project     = "${local.project_id_map[local.env]}"
}
