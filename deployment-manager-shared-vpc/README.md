# Cloud IAP connector

[Cloud Identity-Aware Proxy (Cloud IAP)](https://cloud-dot-devsite.googleplex.com/iap/docs/concepts-overview)
lets Google Cloud Platform (GCP) customers manage access to apps running in App
Engine standard environment, App Engine flexible environment, Compute Engine,
and Google Kubernetes Engine.

Cloud IAP can also target apps hosted on-premises or on other cloud providers
with a Cloud IAP connector. This configurable
[Cloud Deployment Manager](https://cloud.google.com/deployment-manager/docs/)
template creates the resources needed to host and deploy the Cloud IAP connector
into a Cloud IAP-enabled GCP project, forwarding authenticated and authorized
requests to your app.

Within a GCP project, a Cloud IAP connector deploys an
[Ambassador](https://github.com/datawire/ambassador) proxy on a
[Google Kubernetes Engine (GKE)](https://cloud.google.com/kubernetes-engine/docs/)
cluster. This proxy routes traffic secured by Cloud IAP to your app, indirectly
applying
[Cloud Identity and Access Management (Cloud IAM)](https://cloud.google.com/iam/docs/)
access policies.

## Getting Started

The following is a summary of the steps required to enable Cloud IAP for your
on-premises app. For detailed instructions, see
[Enabling Cloud IAP for on-premises apps](https://cloud.google.com/iap/docs/enabling-on-prem-howto).

1.  [Create a GCP project](https://cloud.google.com/resource-manager/docs/creating-managing-projects).

2.  Enable the following APIs:

    -   [Cloud Deployment Manager API V2](https://console.cloud.google.com/apis/library/deploymentmanager.googleapis.com)
    -   [Compute Engine API](https://console.cloud.google.com/apis/library/compute.googleapis.com)
    -   [Kubernetes Engine API](https://console.cloud.google.com/apis/library/container.googleapis.com)

3.  Grant the **Kubernetes Engine Admin** role to the default service account,
    `[PROJECT_NUMBER]@cloudservices.gserviceaccount.com`, by going to the
    [Cloud IAM page](https://console.cloud.google.com/iam-admin/iam).

4.  Upload your SSL certificate(s) for your domain to Google Compute Engine
    (GCE).

    ```
    gcloud compute ssl-certificates create [CERTIFICATE_NAME] --private-key=[PRIVATE_KEY_FILE].pem --certificate=[CERTIFICATE_FILE].pem
    ```

5.  To fit your deployment needs, set routing rules and overwrite default
    parameters in `iap-connector.yaml` file. See the
    [Cloud IAP for on-premises apps](https://cloud.google.com/iap/docs/cloud-iap-for-on-prem-apps-overview#routing_rules)
    overview for information about routing rules.
    
    For shared VPC, set useIpAliases to True. Then set the secondary range parameters 'clusterSecondaryRangeName' and 'servicesSecondaryRangeName'.

6.  Deploy the Cloud IAP connector.

    ```
    gcloud deployment-manager deployments create <deployment_name> --config=iap-connector.yaml
    ```

7.  Associate your source domain with the public IPv4 address of the load
    balancer by updating the DNS resource records within your domain manager.

8.  Turn on Cloud IAP for your app and set what members have access from the
    [Identity-Aware Proxy page](https://console.cloud.google.com/security/iap).

9.  Ensure traffic to your app has been forwarded from the Cloud IAP connector
    by
    [checking the header of a request](https://cloud.google.com/iap/docs/signed-headers-howto).
