# Terraform Module for GCP API Services

This module contains resource files and example variable definition files for enabling and checking the required GCP API services for Cloudera Data Platform (CDP) Public Cloud deployment.

The module can either enable the required APIs (when `enable_apis = true`) or perform a data source lookup to verify that the APIs are already enabled (the default behavior when `enable_apis = false`).

## Usage

The [examples](./examples) directory has example configurations for different scenarios:

* `ex01-enable-apis` uses the module to enable the required GCP APIs for a CDP deployment.

* `ex02-check-apis` shows an example of the lookup-only mode to check if APIs are already enabled.

In each directory an example `terraform.tfvars.sample` values file is included to show input variable values.
