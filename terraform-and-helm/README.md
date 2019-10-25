# Terraform and Helm
The code in this folder is for an approach that uses Terraform and Helm to
deploy the IAP connector. It includes code to create the entire infrastructure
and the Ambassador deployment including the network, IAM, IAP connector, etc.

This code was originally split into separate repos to enable division of
responsibilities for the network team, the security team, and the operations team.
Each directory in this folder was a repo.

Customer specific information was removed from the code.

## Terraform version
The Terraform code was written to be used with 0.11.13 version of Terraform. 
