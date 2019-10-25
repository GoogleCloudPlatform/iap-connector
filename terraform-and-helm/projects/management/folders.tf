/* Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
*/

resource "google_folder" "app" {
  parent       = "${local.root_id}"
  display_name = "${local.app}"
}

resource "google_folder" "network" {
  parent       = "${google_folder.app.name}"
  display_name = "network"
}
