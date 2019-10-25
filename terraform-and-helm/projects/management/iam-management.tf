/* Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
*/

module "iam_management_project" {
  source                  = "github.com/terraform-google-modules/terraform-google-project-factory.git?ref=v2.4.1"
  random_project_id       = true
  name                    = ""
  org_id                  = "${local.org_id}"
  folder_id               = "${google_folder.app.id}"
  billing_account         = "${local.gcp_airgc_billing_id}"
  default_service_account = "keep"
  activate_apis           = [
    "container.googleapis.com",
  ]
}
