locals {
  project_id = "${local.project_id_map[local.env]}"

  project_id_map = {
    dev   = ""
    stage = ""
    prod  = ""
  }
}
