/* Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
*/

# Since we're targeting terraform 0.11.13, we need to use a google provider that
# supports the attributes that existed when the project factory v2.4.1 was
# written
provider "google" {
  version = "~> 2.14.0"
}

provider "google-beta" {
  version = "~> 2.14.0"
}
