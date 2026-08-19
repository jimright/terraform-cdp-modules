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

# ------- Retrieve project details -------
data "google_project" "project" {}

# ------- Lookup GCP API Service Status -------
data "google_project_service" "cdp_api_service" {

  for_each = toset(var.api_services)

  project = data.google_project.project.project_id
  service = each.value

  depends_on = [google_project_service.cdp_api_service]

  lifecycle {
    postcondition {
      condition     = self.id != null
      error_message = "GCP API service '${each.value}' is not enabled in project '${data.google_project.project.project_id}'. Enable it or set enable_apis = true."
    }
  }
}
