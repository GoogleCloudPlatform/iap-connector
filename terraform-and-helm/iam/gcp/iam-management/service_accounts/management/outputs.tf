/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

output "logicmonitor_service_account" {
  value = "${google_service_account.logicmonitor.email}"
}
