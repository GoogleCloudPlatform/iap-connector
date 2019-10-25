/* Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
*/

# Doesn't change often
locals {
  app = ""

  # The default is the org id for airbedandbreakfast.com
  org_id               = ""
  gcp_airgc_billing_id = ""

  # Id of the root folder under which the folders will be placed. If the root is
  # org, use organizations/ord_id format
  root_id = "organizations/${local.org_id}"
}
