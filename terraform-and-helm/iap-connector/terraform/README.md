# GCP IAP Connector
The IAP connector is a proxy for applications that use the Identity Aware Proxy(IAP)
to connect to on-premise or other applications not hosted on Google Cloud Platform (GCP).
At it's heart, the IAP connector is a GKE cluster that runs the Ambassador proxy.

## Prerequisites
The following should have run first:
1. Create the subnets in the host VPC project. The code is in the [gcp-vpc](https://github.airbnb.biz/Airbnb-ITX/gcp-vpc) repository
1. Create the IAM permissions. The code is in the `gcp-iam/iap-iam` directory in the [terraform-iam](https://github.airbnb.biz/Airbnb-ITX/terraform-iam) repository.

## Steps to Create IAP connector
To setup a new IAP connector from scratch:
1. Create Addresses. These are the Static IPs used for the Global Load Balancer
1. Create SSL certificates. SSL certificates need to be imported into GCP if they are created through another service such as DigiCert.
1. Create the IAP GKE cluster.

The first three steps can be done in any order. The key is to get the Terraform 
infrastructure created before the kubernetes deployment.

## Directory Structure
We try to balance the need to separate the lifecycles for Static IPs, SSL 
certificates, and GKE clusters in different regions. It is best for each GKE
cluster to have its own workspace. 

```text
|--- terraform/ # holds the terraform code
     |--- environments/ # holds the infrastructure creation
          |--- dev/ # a directory for each environment, e.g. dev, stage, prod
               |--- addresses/ # creates the static IPs. Has its own workspace
               |--- certificates/ # Imports the SSL certificates. Has its own workspace
               |--- gke/
                    |--- us-east4/ # Holds the clusters for each region.
                         |--- cluster-a/ # Creates the cluster for the region
          |--- shared_tf/ # holds the terraform code shared across environments.
               |--- shared-all.tf # locals needed for all resources.
               |--- shared-gke.tf # locals needed for gke resources.
     |--- modules/ # holds the reusable modules
          |--- gke-cluster/
          |--- ssl-certificates

```

## Add New Addresses
Although static ip addresses are global, they will be used for load balancers
that are created for a specific cluster, which are regional.

Within an environment add a new `google_compute_global_address` resource.

## Add New SSL Certificates
SSL certificates are global and could be applied to multiple load balancers if
traffic is spread across different load balancers.

Within an environment, create a call to the `ssl-certificate` module.
```terraform
module "ssl_certificate_confluence" {
  source      = "../../../modules/ssl-certificates"
  name_prefix = "${local.confluence_name_prefix}"
  certificate = "${var.confluence_certificate}"
  key         = "${var.confluence_key}"
  project_id  = "${local.project_id}"
}
```

Two variables need to be created for each certificate. One is to hold the PEM 
style certificate and the other is to hold the certificate key.

## Add New IAP connectors
An IAP connector is basically a gke cluster with the Ambassador proxy deployed
to it.

Copy a cluster directory with the `cp -R` command to ensure the symlink is
copied correctly.

For example `cp -R cluster-a cluster-b`.

Then update the `terraform/environments/shared_tf/shared-gke.tf` file with new
values for the cluster. This will be done on the locals that are defined below
`region_map` locals. The format for the lowest level `map` variables are:
```terraform
subnets_map = {
    dev = {
      us-east4 = {
        cluster-a = "gusa-s-dev-iap-nodes-a"
      }
    }

    stage = {
      us-east4 = {
        cluster-a = ""
      }
    }

    prod = {
      us-east4 = {
        cluster-a = ""
      }
    }
  }
```

## Add New Environment
A new environment will need static ip addresses, ssl certificates, and clusters.

To create a new environment, copy with the `cp -R` command an environment
directory. Then update the files in the `terraform/environments/shared_tf/`
directory.

## Copyright
Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.
