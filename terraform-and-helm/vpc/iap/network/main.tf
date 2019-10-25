/* Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
*/

module "iap-vpc" {
  source = "github.com/terraform-google-modules/terraform-google-network.git?ref=v0.8.0"

  project_id   = "${local.vpc_project_id}"
  network_name = "${local.vpc_name}"
  routing_mode = "GLOBAL"

  subnets = []

  secondary_ranges = {}
}
