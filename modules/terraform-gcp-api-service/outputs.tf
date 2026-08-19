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

output "api_service_status" {
  description = "Map of GCP API service names to their details. A successful lookup confirms the API is enabled."
  value = {
    for service, details in data.google_project_service.cdp_api_service :
    service => {
      project                    = details.project
      service                    = details.service
      disable_dependent_services = details.disable_dependent_services
    }
  }
}
