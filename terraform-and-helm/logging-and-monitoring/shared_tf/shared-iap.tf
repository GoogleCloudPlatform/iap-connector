/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

# This file should contain values specific to IAP connector application.
locals {
  iap_pubsub_topic_name            = "iap-gke-${local.env}"
  iap_gke_pubsub_topic             = "pubsub.googleapis.com/projects/${local.logging_monitoring_project_id}/topics/${local.iap_pubsub_topic_name}"
  iap_gke_pubsub_sumo_sub_name     = "${local.iap_pubsub_topic_name}-sumologic"
  iap_gke_pubsub_sumo_sub_endpoint = "${local.iap_gke_pubsub_sumo_sub_endpoint_map[local.env]}"

  iap_project_id = "${local.iap_project_id_map[local.env]}"

  iap_project_id_map = {
    dev   = ""
    stage = ""
    prod  = ""
  }

  iap_gke_pubsub_sumo_sub_endpoint_map = {
    dev   = ""
    stage = ""
    prod  = ""
  }
}
