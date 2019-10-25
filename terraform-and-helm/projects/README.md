# terraform-gcp-projects

## Prerequisites:
1. The terraform project needs the "Cloud Resource Manager" API enabled
1. The terraform service project needs the following permissions.
    1. Folder Admin
    1. Project Creator
    1. Billing Account User at the organizational node level

## Project Factory
We make use of Google's Cloud Foundation Toolkit's (CFT) 
[project factory](https://github.com/terraform-google-modules/terraform-google-project-factory)
CFT's project factory has support for shared vpcs and billing labels out of the 
box. Since we use terraform 0.11.x, we need to use v2.4.1 of the project factory.

## New application
To create a new application and folders, add a new directory that creates the
folders and projects. You may want to create a new module for the application
in the `modules` directory.

## Copyright
Copyright 2019 Google LLC. This software is provided as is, without warranty 
or representation for any use or purpose. Your use of it is subject to your 
agreement with Google.