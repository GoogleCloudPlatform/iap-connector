/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

locals {
  host_vpc_project = ""

  gke_create_firewalls_role_id      = ""
  gke_create_firewalls_role_id_long = "projects/${local.host_vpc_project}/roles/${local.gke_create_firewalls_role_id}"

  service_project_number_map = {
    dev   = ""
    stage = ""
    prod  = ""
  }

  iap_project_id_map = {
    dev   = ""
    stage = ""
    prod  = ""
  }

  gke_service_account_map = {
    dev   = "service-${local.service_project_number_map["dev"]}@container-engine-robot.iam.gserviceaccount.com"
    stage = "service-${local.service_project_number_map["stage"]}@container-engine-robot.iam.gserviceaccount.com"
    prod  = "service-${local.service_project_number_map["prod"]}@container-engine-robot.iam.gserviceaccount.com"
  }

  jenkins_service_account_map = {
    dev   = ""
    stage = ""
    prod  = ""
  }

  jenkins_roles = [
    "roles/container.admin",
    "roles/compute.loadBalancerAdmin",
  ]
}
