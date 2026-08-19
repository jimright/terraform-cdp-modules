# Copyright 2026 Cloudera, Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

variable "enable_apis" {
  type = bool

  description = "Flag to specify if the GCP APIs should be enabled. When false (default) only a data source lookup is performed to check if the APIs are already enabled."

  default = false
}

variable "api_services" {
  type        = list(string)
  description = "List of GCP API services to enable or check. Defaults to the APIs required for Cloudera CDP deployment."

  # Reference: https://docs.cloudera.com/cdp-public-cloud/cloud/requirements-gcp/topics/mc-gcp_apis.html
  default = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "servicenetworking.googleapis.com",
    "sqladmin.googleapis.com",
    "storage.googleapis.com",
  ]
}

variable "disable_on_destroy" {
  type = bool

  description = "Flag to control whether the API services should be disabled when the resource is destroyed. Defaults to false to avoid accidentally breaking other services in the project."

  default = false
}

variable "disable_dependent_services" {
  type = bool

  description = "Flag to control whether services that are enabled and which depend on the service being disabled should also be disabled when the resource is destroyed. Only relevant if disable_on_destroy is true."

  default = false
}
