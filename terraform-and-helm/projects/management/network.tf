/* Copyright 2019 Google LLC. This software is provided as is, without warranty
 * or representation for any use or purpose. Your use of it is subject to your
 * agreement with Google.
*/

locals {
  iap_host_project_name = ""
}

resource "random_id" "iap_host" {
  byte_length = 4
  prefix      = "${local.iap_host_project_name}-"
}

module "iap_host" {
  source = "../modules/shared_vpc_project"

  project_name           = "${local.iap_host_project_name}"
  project_id             = "${random_id.iap_host.hex}"
  billing_account_id     = "${local.gcp_airgc_billing_id}"
  folder_id              = "${google_folder.network.name}"
  create_default_network = false

  services = [
    "compute.googleapis.com",
    "oslogin.googleapis.com",
    "iam.googleapis.com",
    "iap.googleapis.com",
    "iamcredentials.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "dns.googleapis.com",
    "container.googleapis.com",
  ]
}
