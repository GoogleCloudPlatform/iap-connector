/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

variable "topic_name" {
  description = "The name for the Cloud Pub/Sub topic"
}

variable "subscription_name" {
  description = "The name for the Cloud Pub/Sub subscription"
}

variable "sub_push_endpoint" {
  description = "The endpoint for the subscription push"
}
