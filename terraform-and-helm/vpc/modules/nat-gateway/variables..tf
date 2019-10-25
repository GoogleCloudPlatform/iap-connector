/* Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
*/

variable "router_name" {
  description = "The name for the Cloud Router"
}

variable "router_region" {
  description = "The region for the Cloud Router"
}

variable "network_self_link" {
  description = "The self link for vpc network"
}

variable "nat_gateway_name" {
  description = "The name for the Cloud NAT Gateway"
}
