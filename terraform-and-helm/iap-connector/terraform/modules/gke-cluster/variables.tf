/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

variable "project" {
  description = "The project in which to hold the components"
}

variable "location" {
  description = "gke nodes location"
}

variable "network_name" {
  description = "gke network name"
}

variable "subnet_name" {
  description = "gke subnet name"
}

variable "cluster_service_acct_id" {
  description = "The service account id for the cluster"
}

variable "pods_secondary_range_name" {
  description = "The secondary range in the subnet for pods."
}

variable "services_secondary_range_name" {
  description = "The secondary range in the subnet for services."
}

variable "gke_nodes_machine_type" {
  description = "Compute engine machine types used to create gke nodes"
}

variable "max_pods_per_node" {
  description = "The maximum number of pods per node. Needed to optimize IP allocation. It is used for the default pods per node and for the default pods for primary and secondary node pools"
}

variable "gke_nodes_disk_size_gb" {
  description = "gke nodes disk size"
}

variable "gke_nodes_disk_type" {
  description = "gke nodes disk type"
  default     = "pd-ssd"
}

variable "primary_initial_node_count" {
  description = "Size of the initial node count for the primary node pool when the priamry node pool is created."
}

variable "secondary_initial_node_count" {
  description = "Size of the initial node count for the secondary node pool when the secondary node pool is created.l"
  default     = "0"
}

variable "master_cidr_block" {
  description = "The cidr blocks used by the master nodes."
}

variable "cluster_name" {
  description = "Gke cluster name"
}

variable "gke_node_tags" {
  description = "Gke node tags"
  type        = "list"
}

variable "enable_autoscaling" {
  description = "Whether to enable autoscaling of node cluster. Should be 'true' or 'false'"
}

variable "primary_max_node_count" {
  description = "Maximum node count for autoscaling the primary node pool"
}

variable "primary_min_node_count" {
  description = "Minimum node count for autoscaling the primary node pool"
}

variable "secondary_max_node_count" {
  description = "Maximum node count for autoscaling the secondary node pool"
}

variable "secondary_min_node_count" {
  description = "Minimum node count for autoscaling the secondary node pool"
  default     = "0"
}

variable "disable_horizontal_pod_autoscaling" {
  description = "Whether to disable horizontal pod autoscaling. Should be 'true' or 'false'"
  default     = "false"
}

variable "master_authorized_network" {
  description = "master authorized networks"
  type        = "map"
}

variable "gke_node_list_of_roles" {
  description = "list of roles to assign to nodes service account"
  type        = "list"
}

variable "gke_version" {
  description = "gke version to deploy"
}
