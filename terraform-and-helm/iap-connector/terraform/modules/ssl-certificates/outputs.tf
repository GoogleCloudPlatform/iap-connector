/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

output "certificate_name" {
  value = "${google_compute_ssl_certificate.app.name}"
}

output "certificate_id" {
  value = "${google_compute_ssl_certificate.app.certificate_id}"
}
