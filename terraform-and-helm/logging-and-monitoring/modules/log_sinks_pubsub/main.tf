/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

resource "google_logging_project_sink" "main" {
  project = "${var.sink_project_id}"
  name    = "${var.sink_name}"

  # export to a pubsub topic in the logging and monitoring management project
  destination = "${var.pubsub_topic}"

  # Log all messages related to gke
  filter = "${var.sink_filter}"

  # Use a unique writer (creates a unique service account used for writing)
  unique_writer_identity = "${var.enable_unique_writer}"
}

resource "google_pubsub_topic_iam_member" "sink_pubsub_writer" {
  project = "${var.pubsub_project_id}"
  topic   = "${var.pubsub_topic}"
  role    = "${var.pubsub_topic_role}"
  member  = "${google_logging_project_sink.main.writer_identity}"
}
