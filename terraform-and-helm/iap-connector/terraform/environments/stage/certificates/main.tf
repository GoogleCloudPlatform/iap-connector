/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

locals {
  env                    = "stage"
  jira_name_prefix       = "jira-${local.env}-"
  confluence_name_prefix = "confluence-${local.env}-"
}

resource "google_compute_ssl_policy" "ssl_policy" {
  name            = ""
  profile         = "RESTRICTED"
  min_tls_version = "TLS_1_2"
  project         = "${local.project_id}"
}

module "ssl_certificate_jira" {
  source      = "../../../modules/ssl-certificates"
  name_prefix = "${local.jira_name_prefix}"
  certificate = "${var.jira_certificate}"
  key         = "${var.jira_key}"
  project_id  = "${local.project_id}"
}

module "ssl_certificate_confluence" {
  source      = "../../../modules/ssl-certificates"
  name_prefix = "${local.confluence_name_prefix}"
  certificate = "${var.confluence_certificate}"
  key         = "${var.confluence_key}"
  project_id  = "${local.project_id}"
}
