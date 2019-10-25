/* Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
*/

# We need to call the iap module for each environment
module "iap_dev" {
  source                  = "../modules/iap_project"
  app                     = "${local.app}"
  env                     = "dev"
  billing_account_id      = "${local.billing_account_id}"
  folder_id               = "${google_folder.iap_dev.id}"
  host_vpc_project        = "${local.host_vpc_project}"
  subnet_ids              = "${local.subnet_id_map["dev"]}"
  default_service_account = "${local.default_service_account}"
  activate_apis           = "${local.activate_apis}"
}

module "iap_stage" {
  source                  = "../modules/iap_project"
  app                     = "${local.app}"
  env                     = "stage"
  billing_account_id      = "${local.billing_account_id}"
  folder_id               = "${google_folder.iap_stage.id}"
  host_vpc_project        = "${local.host_vpc_project}"
  subnet_ids              = "${local.subnet_id_map["stage"]}"
  default_service_account = "${local.default_service_account}"
  activate_apis           = "${local.activate_apis}"
}

module "iap_prod" {
  source                  = "../modules/iap_project"
  app                     = "${local.app}"
  env                     = "prod"
  billing_account_id      = "${local.billing_account_id}"
  folder_id               = "${google_folder.iap_prod.id}"
  host_vpc_project        = "${local.host_vpc_project}"
  subnet_ids              = "${local.subnet_id_map["prod"]}"
  default_service_account = "${local.default_service_account}"
  activate_apis           = "${local.activate_apis}"
}
