# GCP IAM Management
The `iam-management` project manages service accounts that will have access to 
other projects. For example, the Jenkins service accounts for IAP live in the
`iam-management` project.

The policies that enable the service account projects to work inside of other
projects will exist in the iam policies terraform for those projects.

Since service accounts for dev, stage, and prod will have their own lifecycle,
there are separate workspaces for dev, stage, and prod.

## Service Account Creation
Service accounts are created in the `service_accounts/<env>` directory for that
environment.

## Shared.tf
Each environment links to the `shared.tf` file that has `locals` that are shared
across all environments.

The `local.env` value that is used in the `shared.tf` file is created in the
`main.tf` file in the environment directory. For example, the following block is
in `service_accounts/main.tf`

```terraform
locals {
  env = "dev"
}
```

## Creating a new service account
Create a new `google_service_account` resource in the `service_accounts/<env>`
directory.

## Creating a new environment
If we want to create a new environment, e.g. "qa", then 
1. `cp -R dev <new env>`
1. Update the `local.env` value in the `main.tf` file.

The `cp -R` command ensures the symlink for the `shared.tf` is copied directly.
