/* Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
*/

provider "google" {
  version = "~>2.16.0"
  project = "${local.vpc_project_id}"
}

provider "google-beta" {
  version = "~>2.16.0"
  project = "${local.vpc_project_id}"
}
