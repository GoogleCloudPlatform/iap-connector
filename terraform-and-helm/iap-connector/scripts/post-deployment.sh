#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o xtrace
set -o pipefail

# this policy is created through terraform, we attach it with gcloud to https proxies since gke ingresses does not support that yet
# see here https://github.com/kubernetes/ingress-gce/issues/246 for more information
SSL_POLICY_NAME="example-ssl-policy"
project_id="${1}"

# update every target https proxy created by gke ingress to use ssl policy 1.2 restricted 
for target_https_proxy in $(set -e; gcloud compute target-https-proxies list --filter "description:ingress-name" --format="value(name)" --project "${project_id}"); do
  gcloud compute target-https-proxies update "${target_https_proxy}" --ssl-policy "${SSL_POLICY_NAME}" --project "${project_id}";
done
