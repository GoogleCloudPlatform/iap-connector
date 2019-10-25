# GCP IAP IAM
We do not need to assign the Host Service Agent User role to the GKE service
accounts in the service projects since Google's 
[Project Factory](https://github.com/terraform-google-modules/terraform-google-project-factory) 
already does it.

## Create roles
We need to add permissions for the GKE service account in the service projects
to create firewall rules in the host project. To do this we need to create a
custom role in the host project. Then we assign the custom role to the service 
account users for each environment.

To create a new role, update 

## Add new project
Update the maps in the `shared.tf` file. The maps are key-value pairs that map
environments to the appropriate values.

Create a new environment directory with `cp -R` to copy the files for a new 
environment. We use this command to copy so that the symlink to the `shared.tf`
file is copied correctly.

Change <env> to the name of the new environment.
```shell-script
cp -R dev <env>
```

Finally update the resource to assign the GKE Create Firewall role in the host vpc
 project to the GKE service account in the service project. Replace `<env>` in
 the example below with the name of the new environment.
 ```terraform
resource "google_project_iam_member" "gke_svc_gke_firewall_user" {
  project = "${local.host_vpc_project}"
  role    = "${local.gke_create_firewalls_role_id_long}"
  member  = "serviceAccount:${local.gke_service_account_map["<env>"]}"
}
```

## Copyright
Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
