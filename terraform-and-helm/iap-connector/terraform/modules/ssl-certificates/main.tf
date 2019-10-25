/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

resource "google_compute_ssl_certificate" "app" {
  name_prefix = "${var.name_prefix}"
  certificate = "${var.certificate}"
  private_key = "${var.key}"
  project     = "${var.project_id}"

  lifecycle {
    create_before_destroy = "true"
  }
}
