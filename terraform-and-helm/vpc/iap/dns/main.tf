/* Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
*/

data "google_compute_network" "iap-vpc" {
  name    = "${local.vpc_name}"
  project = "${local.vpc_project_id}"
}

resource "google_dns_managed_zone" "airbnb-private-zone" {
  provider = "google-beta"

  name        = ""
  dns_name    = ""
  description = ""

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = "${data.google_compute_network.iap-vpc.self_link}"
    }
  }

  forwarding_config {
    target_name_servers {
      ipv4_address = ""
    }
  }
}
