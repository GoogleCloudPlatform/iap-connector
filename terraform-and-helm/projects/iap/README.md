# IAP Folder and Project Creation
This creates the GCP folders and projects for the IAP connector

## Create new folder
Create a new folder for the new environment by adding an entry in folders.tf
Replace `<env>` with the name of the environment, e.g. "stage"
```hcl-terraform
resource "google_folder" "iap_<env>" {
  parent       = "${google_folder.app.name}"
  display_name = "${local.app}_<env>"
}
```

## Create new project
Make a call to the `iap_project` module.
Replace `<env>` with the name of the environment, e.g. "stage"
```hcl-terraform
module "iap_<env>" {
  source           = "../modules/iap_project"
  env              = "<env>"
  folder_id        = "${google_folder.iap_<env>.id}"
  host_vpc_project = "${local.host_vpc_project}"
  subnet_ids       = "${local.subnet_id_map["<env>"]}"
}
```
## Copyright
Copyright 2019 Google LLC. This software is provided as is, without warranty 
or representation for any use or purpose. Your use of it is subject to your 
agreement with Google.



