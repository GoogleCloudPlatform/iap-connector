/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

# We'll create a custom role instead of using the compute.securityAdmin role
# that has wider privileges than we need for kubernetes.
# Note the warnings in https://www.terraform.io/docs/providers/google/r/google_project_iam_custom_role.html
# about the time (up to 37 days) it takes for role names to become available
# after deletion.
resource "google_project_iam_custom_role" "gke_create_firewalls_role" {
  project     = "${local.host_vpc_project}"
  role_id     = "${local.gke_create_firewalls_role_id}"
  title       = ""
  description = "Enables kubernetes to create firewall rules"

  permissions = [
    "compute.firewalls.create",
    "compute.firewalls.delete",
    "compute.firewalls.get",
    "compute.firewalls.list",
    "compute.firewalls.update",
    "compute.networks.updatePolicy",
  ]
}
