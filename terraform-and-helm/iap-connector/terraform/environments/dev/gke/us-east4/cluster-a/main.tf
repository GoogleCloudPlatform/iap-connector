/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

locals {
  env        = "dev"
  region     = "us-east4"
  cluster_id = "cluster-a"
}

# private gke cluster
module "gke_private" {
  source = "../../../../../modules/gke-cluster"

  project                            = "${local.project_id}"
  location                           = "${local.location}"
  network_name                       = "${local.gke_network_name}"
  subnet_name                        = "${local.gke_subnet_name}"
  cluster_service_acct_id            = "${local.cluster_service_acct_id}"
  pods_secondary_range_name          = "${local.gke_pods_secondary_range_name}"
  services_secondary_range_name      = "${local.gke_services_secondary_range_name}"
  cluster_name                       = "${local.cluster_name}"
  primary_initial_node_count         = "${local.primary_initial_node_count_per_zone}"
  secondary_initial_node_count       = "${local.secondary_intial_node_count_per_zone}"
  gke_nodes_machine_type             = "${local.gke_nodes_machine_type}"
  max_pods_per_node                  = "${local.max_pods_per_node}"
  gke_nodes_disk_size_gb             = "${local.gke_nodes_disk_size_gb}"
  gke_node_list_of_roles             = "${local.gke_node_list_of_roles}"
  master_cidr_block                  = "${local.master_cidr_block}"
  master_authorized_network          = "${local.master_authorized_network}"
  gke_node_tags                      = "${local.gke_node_tags}"
  enable_autoscaling                 = "${local.enable_autoscaling}"
  primary_max_node_count             = "${local.primary_max_node_count}"
  primary_min_node_count             = "${local.primary_min_node_count}"
  secondary_max_node_count           = "${local.secondary_max_node_count}"
  secondary_min_node_count           = "${local.secondary_min_node_count}"
  disable_horizontal_pod_autoscaling = "${local.disable_horizontal_pod_autoscaling}"
  gke_version                        = "${local.gke_version}"
}
