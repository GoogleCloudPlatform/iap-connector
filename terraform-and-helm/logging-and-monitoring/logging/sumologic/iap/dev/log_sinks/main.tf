/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

locals {
  env = "dev"
}

# Must use double quotes for the filter. Single quotes is not accepted as valid
# resource for the log export
module "gke_log_sink" {
  source               = "../../../../../modules/log_sinks_pubsub"
  sink_project_id      = "${local.iap_project_id}"
  sink_name            = "gke-${local.env}-pubsub"
  pubsub_topic         = "${local.iap_gke_pubsub_topic}"
  sink_filter          = "resource.type=\"gke_cluster\" OR resource.type=\"k8s_cluster\" OR resource.type=\"k8s_node\" OR resource.type=\"k8s_pod\""
  enable_unique_writer = true
  pubsub_project_id    = "${local.logging_monitoring_project_id}"
  pubsub_topic_role    = "roles/pubsub.publisher"
}
