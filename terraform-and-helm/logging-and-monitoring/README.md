# Terraform GCP Logging and Monitoring
Terraform code to manage the centralized logging and monitoring. It initially
builds the GCP log sinks and the Pub/Sub topics and subscriptions to send GCP
logs to Sumologic.

## Basic Architecture
[Cloud Pub/Sub](https://cloud.google.com/pubsub/) is a messaging and event
ingestion system that follows the publisher-subscription model. The setup to
send GCP logs to SumoLogic is to create a log sink in the project of the
application that sends logs to a topic Cloud Pub/Sub. Then SumoLogic has a
subscription that pushes the logs to SumoLogic's endpoint.

SumoLogic has a [diagram](https://help.sumologic.com/07Sumo-Logic-Apps/06Google/Google_Kubernetes_Engine_(GKE)_-_Control_Plane/Collect_logs_and_metrics_for_the_GKE_-_Control_Plane_App)
that shows the log collection process.

## Directory Structure
We structured the project to allow additions for directories for monitoring and
for other applications besides IAP that need to send logs to SumoLogic.

The files in `shared_tf` are symlinked to in the different workspaces. Use
`cp -R` when copying directories to ensure the symlink is copied correctly.

```
|--- logging/
     |--- sumologic/ # the collector of logs
          |--- iap/ # the application logs
               |--- dev/ # the environment
                    |--- log-sinks/  
                    |--- pubsub/
|--- modules/
     |--- log-sinks-pusbsub/ # log sinks that sends logs to a Pub/Sub topic
|--- shared_tf/ # code shared among different workspaces
     |--- shared-all.tf # code shared by all workspaces
     |--- shared-iap.tf # code shared by iap workspaces
```

## Create new environment
To create log sinks and Pub/Sub topics and subscriptions for a new environment,
1. Copy the environment `cp -R dev <env>`
1. Update the values in the shared_tf files for any locals that are maps.

## Copyright
Copyright 2019 Google LLC. This software is provided as is, without warranty or 
representation for any use or purpose. Your use of it is subject to your 
agreement with Google.
 