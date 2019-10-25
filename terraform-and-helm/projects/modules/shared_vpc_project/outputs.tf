/* Copyright 2019 Google LLC. This software is provided as is, without warranty
 * or representation for any use or purpose. Your use of it is subject to your
 * agreement with Google.
*/

output "project_id" {
  value = "${google_project.shared_vpc.project_id}"
}

output "project_number" {
  value = "${google_project.shared_vpc.number}"
}
