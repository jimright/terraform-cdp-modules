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

# ------- Data Storage -------
output "azure_data_storage_account" {
  value       = module.azure_storage.azure_data_storage_account
  description = "Azure data storage account name"
}

output "azure_data_storage_container" {
  value       = module.azure_storage.azure_data_storage_container
  description = "Azure data storage container name"
}

output "azure_data_storage_location" {
  value       = module.azure_storage.azure_data_storage_location
  description = "Azure data storage location (abfs:// URI)"
}

# ------- Log Storage -------
output "azure_log_storage_account" {
  value       = module.azure_storage.azure_log_storage_account
  description = "Azure log storage account name"
}

output "azure_log_storage_container" {
  value       = module.azure_storage.azure_log_storage_container
  description = "Azure log storage container name"
}

output "azure_log_storage_location" {
  value       = module.azure_storage.azure_log_storage_location
  description = "Azure log storage location (abfs:// URI)"
}

# ------- Backup Storage -------
output "azure_backup_storage_account" {
  value       = module.azure_storage.azure_backup_storage_account
  description = "Azure backup storage account name"
}

output "azure_backup_storage_container" {
  value       = module.azure_storage.azure_backup_storage_container
  description = "Azure backup storage container name"
}

output "azure_backup_storage_location" {
  value       = module.azure_storage.azure_backup_storage_location
  description = "Azure backup storage location (abfs:// URI)"
}
