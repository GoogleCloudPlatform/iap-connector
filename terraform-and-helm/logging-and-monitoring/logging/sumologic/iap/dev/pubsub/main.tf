/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

locals {
  env = "dev"
}

module "gke" {
  source            = "../../../../../modules/pubsub_push"
  topic_name        = "${local.iap_pubsub_topic_name}"
  subscription_name = "${local.iap_gke_pubsub_sumo_sub_name}"
  sub_push_endpoint = "${local.iap_gke_pubsub_sumo_sub_endpoint}"
}
