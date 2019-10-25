/* Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
*/

resource "google_compute_router" "nat-router" {
  name    = "${var.router_name}"
  region  = "${var.router_region}"
  network = "${var.network_self_link}"

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.nat_gateway_name}"
  router                             = "${google_compute_router.nat-router.name}"
  region                             = "${google_compute_router.nat-router.region}"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
