/* Copyright 2019 Google LLC. This software is provided as is, without warranty
 * or representation for any use or purpose. Your use of it is subject to your
 * agreement with Google.
*/

resource "google_project" "shared_vpc" {
  name                = "${var.project_name}"
  project_id          = "${var.project_id}"
  billing_account     = "${var.billing_account_id}"
  folder_id           = "${var.folder_id}"
  auto_create_network = "${var.create_default_network}"
}

resource "google_project_services" "shared_vpc" {
  project  = "${google_project.shared_vpc.project_id}"
  services = "${var.services}"
}

resource "google_compute_shared_vpc_host_project" "shared_vpc" {
  project = "${google_project.shared_vpc.project_id}"
}
