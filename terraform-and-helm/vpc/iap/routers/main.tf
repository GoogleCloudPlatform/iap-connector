/* Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
*/

locals {
  google_asn = "16550"
}

resource "google_compute_router" "us-east4" {
  name    = ""
  network = "${local.vpc_name}"
  region  = "us-east4"
  project = "${local.vpc_project_id}"

  bgp {
    asn            = "${local.google_asn}"
    advertise_mode = "CUSTOM"

    # us-east4 summary route for IAP
    advertised_ip_ranges {
      range = "0"
    }

    # us-west1 summary route for IAP
    advertised_ip_ranges {
      range = ""
    }
  }
}

resource "google_compute_router" "us-west1" {
  name    = ""
  network = "${local.vpc_name}"
  region  = "us-west1"
  project = "${local.vpc_project_id}"

  bgp {
    asn            = "${local.google_asn}"
    advertise_mode = "CUSTOM"

    # us-west1 summary route for IAP
    advertised_ip_ranges {
      range = ""
    }

    # us-east4 summary route for IAP
    advertised_ip_ranges {
      range = ""
    }
  }
}
