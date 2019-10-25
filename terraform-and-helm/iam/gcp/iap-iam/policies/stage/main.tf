/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

resource "google_project_iam_member" "gke_svc_gke_firewall_user" {
  project = "${local.host_vpc_project}"
  role    = "${local.gke_create_firewalls_role_id_long}"
  member  = "serviceAccount:${local.gke_service_account_map["stage"]}"
}

resource "google_project_iam_member" "jenkins_svc_user" {
  provider = "google-beta"
  count   = "${length(local.jenkins_roles)}"
  project = "${local.iap_project_id_map["stage"]}"
  role    = "${local.jenkins_roles[count.index]}"
  member  = "serviceAccount:${local.jenkins_service_account_map["stage"]}"
}
