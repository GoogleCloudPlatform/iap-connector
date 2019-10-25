/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

locals {
  iam_mgmt_project_id         = ""
  jenkins_iap_sa_account_id   = ""
  jenkins_iap_sa_display_name = "Jenkins service account for IAP ${local.env}"
}
