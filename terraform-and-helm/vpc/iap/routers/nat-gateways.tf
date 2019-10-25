/* Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
*/

data "google_compute_network" "iap-vpc" {
  name    = "${local.vpc_name}"
  project = "${local.vpc_project_id}"
}

module "nat-useast4" {
  source            = "../../modules/nat-gateway"
  router_name       = ""
  router_region     = "us-east4"
  network_self_link = "${data.google_compute_network.iap-vpc.self_link}"
  nat_gateway_name  = "${local.vpc_name}-nat-gateway-us-east4"
}

module "nat-us-west1" {
  source            = "../../modules/nat-gateway"
  router_name       = ""
  router_region     = "us-west1"
  network_self_link = "${data.google_compute_network.iap-vpc.self_link}"
  nat_gateway_name  = "${local.vpc_name}-nat-gateway-us-west1"
}
