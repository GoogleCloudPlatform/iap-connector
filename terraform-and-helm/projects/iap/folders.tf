/* Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
*/

resource "google_folder" "app" {
  parent       = "${local.root_id}"
  display_name = "${local.app}"
}

# Looked into iterating over a list of environments for these folders. That
# approach doesn't work since we need to feed the folder ids to the calls to
# create projects
resource "google_folder" "iap_dev" {
  parent       = "${google_folder.app.name}"
  display_name = "${local.app}_dev"
}

resource "google_folder" "iap_stage" {
  parent       = "${google_folder.app.name}"
  display_name = "${local.app}_stage"
}

resource "google_folder" "iap_prod" {
  parent       = "${google_folder.app.name}"
  display_name = "${local.app}_prod"
}
