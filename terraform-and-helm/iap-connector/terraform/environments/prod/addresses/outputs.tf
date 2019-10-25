/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

output "iap_atlassian_lb_ip" {
  value = "${google_compute_global_address.iap_atlsn_lb.address}"
}
  
output "iap_atlassian_lb_ip_name" {
  value = "${google_compute_global_address.iap_atlsn_lb.name}"
}
