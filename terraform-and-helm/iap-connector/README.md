# GCP IAP Connector

This repo contains most of the resources to deploy IAP-connector. The folder structure is expalined below:


```text
|--- terraform/ # holds the terraform code to create infrastructure 
|--- helm/ # holds the IAP-connector helm chart to deploy ambassador to the cluster
|--- scripts/ # holds scripts to run with jenkins jobs
|--- kube/ # holds any custom yaml files needed to bootstrap the gke cluster
|--- Jenkinsfile # holds the jenkins pipeline code to deploy iap-connector helm chart
```

## Copyright
Copyright 2019 Google LLC. This software is provided as is, without warranty
or representation for any use or purpose. Your use of it is subject to your
agreement with Google.