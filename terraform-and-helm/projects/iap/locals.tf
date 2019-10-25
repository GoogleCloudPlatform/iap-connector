/* Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
*/

# Doesn't change often
locals {
  app = ""

  # The default is the org id for airbedandbreakfast.com
  org_id             = ""
  billing_account_id = ""
  host_vpc_project   = ""

  # Id of the root folder under which the folders will be placed. If the root is
  # org, use organizations/ord_id format
  root_id = "organizations/${local.org_id}"

  # Once we install gcloud onto the TFE GCP worker, we should change this to 'delete'
  default_service_account = "keep"

  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "cloudbilling.googleapis.com",
    "iap.googleapis.com",
  ]
}

# Section changes per environment
locals {
  # the subnets must have the form
  # "projects/<host_vpc_project>/regions/<subnet_region>/subnetworks/<subnet_name>"
  subnet_id_map = {
    dev   = ["projects/${local.host_vpc_project}/regions/us-east4/subnetworks/"]
    stage = ["projects/${local.host_vpc_project}/regions/us-east4/subnetworks/"]
    prod  = ["projects/${local.host_vpc_project}/regions/us-east4/subnetworks/"]
  }
}
