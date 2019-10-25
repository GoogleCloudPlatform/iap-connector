/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

resource "google_pubsub_topic" "main" {
  name = "${var.topic_name}"
}

resource "google_pubsub_subscription" "main" {
  name  = "${var.subscription_name}"
  topic = "${google_pubsub_topic.main.name}"

  push_config {
    push_endpoint = "${var.sub_push_endpoint}"
  }
}
