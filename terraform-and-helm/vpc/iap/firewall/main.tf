/* Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
*/

# Nexpose is a security scanner. It has instances in AWS that needs access to
# run internal security scan in GCP.
resource "google_compute_firewall" "allow_nexpose" {
  name      = ""
  network   = "${local.vpc_name}"
  project   = "${local.vpc_project_id}"
  direction = "INGRESS"

  allow {
    protocol = "all"
  }

  source_ranges = [

  ]
}

resource "google_compute_firewall" "default_deny" {
  name      = ""
  network   = "${local.vpc_name}"
  project   = "${local.vpc_project_id}"
  direction = "INGRESS"
  priority  = 65533

  deny {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}
