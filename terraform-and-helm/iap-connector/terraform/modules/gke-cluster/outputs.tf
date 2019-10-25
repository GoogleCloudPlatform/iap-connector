/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

output "cluster_name" {
  value = "${google_container_cluster.private-gke.name}"
}

output "location" {
  value = "${var.location}"
}

output "project" {
  value = "${var.project}"
}
