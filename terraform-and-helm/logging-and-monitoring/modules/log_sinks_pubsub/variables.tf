/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

variable "sink_project_id" {
  description = "The project id for the project in which to place the log sink"
}

variable "sink_name" {
  description = "Name of the log sink"
}

variable "pubsub_topic" {
  description = "The Pub/Sub topic destination for the log sink. It should have the form 'pubsub.googleapis.com/projects/<project-id>/topics/<topic-name>'"
}

variable "sink_filter" {
  description = "The filter for the logs that will be sent to the log sink."
}

variable "enable_unique_writer" {
  default     = "true"
  description = "Whether to enable the unique writer identity for the log sink. It is recommended to set this value to 'true'."
}

variable "pubsub_project_id" {
  description = "The project id for the project that contains the Pub/Sub topic"
}

variable "pubsub_topic_role" {
  default     = "roles/pubsub.publisher"
  description = "The role for the Pub/Sub topic to give the log sink writer. It's usually 'roles/pubsub.publisher'"
}
