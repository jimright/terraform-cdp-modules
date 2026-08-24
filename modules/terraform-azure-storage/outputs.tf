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
  value       = local.data_account_name
  description = "Azure data storage account name"
}

output "azure_data_storage_container" {
  value       = local.data_container_name
  description = "Azure data storage container name"
}

output "azure_data_storage_location" {
  value       = "abfs://${local.data_container_name}@${local.data_account_name}.dfs.core.windows.net"
  description = "Azure data storage location (abfs:// URI)"
}

output "azure_data_storage_account_id" {
  value = (
    var.create_data_storage
    ? azurerm_storage_account.cdp_storage_locations[local.resolved_data_storage_account].id
    : data.azurerm_storage_account.existing_storage[var.existing_data_storage_account].id
  )
  description = "Azure data storage account ID"
}

output "azure_data_storage_account_primary_dfs_endpoint" {
  value = (
    var.create_data_storage
    ? azurerm_storage_account.cdp_storage_locations[local.resolved_data_storage_account].primary_dfs_endpoint
    : data.azurerm_storage_account.existing_storage[var.existing_data_storage_account].primary_dfs_endpoint
  )
  description = "Azure data storage account primary DFS endpoint"
}

output "azure_data_storage_container_id" {
  value = (
    var.create_data_storage
    ? azurerm_storage_container.cdp_data_storage[0].id
    : data.azurerm_storage_container.existing_data_storage[0].id
  )
  description = "Azure data storage container ID"
}

# ------- Log Storage -------
output "azure_log_storage_account" {
  value       = local.log_account_name
  description = "Azure log storage account name"
}

output "azure_log_storage_container" {
  value       = local.log_container_name
  description = "Azure log storage container name"
}

output "azure_log_storage_location" {
  value       = "abfs://${local.log_container_name}@${local.log_account_name}.dfs.core.windows.net"
  description = "Azure log storage location (abfs:// URI)"
}

output "azure_log_storage_account_id" {
  value = (
    var.create_log_storage
    ? azurerm_storage_account.cdp_storage_locations[local.resolved_log_storage_account].id
    : data.azurerm_storage_account.existing_storage[var.existing_log_storage_account].id
  )
  description = "Azure log storage account ID"
}

output "azure_log_storage_account_primary_dfs_endpoint" {
  value = (
    var.create_log_storage
    ? azurerm_storage_account.cdp_storage_locations[local.resolved_log_storage_account].primary_dfs_endpoint
    : data.azurerm_storage_account.existing_storage[var.existing_log_storage_account].primary_dfs_endpoint
  )
  description = "Azure log storage account primary DFS endpoint"
}

output "azure_log_storage_container_id" {
  value = (
    var.create_log_storage
    ? azurerm_storage_container.cdp_log_storage[0].id
    : data.azurerm_storage_container.existing_log_storage[0].id
  )
  description = "Azure log storage container ID"
}

# ------- Backup Storage -------
output "azure_backup_storage_account" {
  value       = local.backup_account_name
  description = "Azure backup storage account name"
}

output "azure_backup_storage_container" {
  value       = local.backup_container_name
  description = "Azure backup storage container name"
}

output "azure_backup_storage_location" {
  value       = "abfs://${local.backup_container_name}@${local.backup_account_name}.dfs.core.windows.net"
  description = "Azure backup storage location (abfs:// URI)"
}

output "azure_backup_storage_account_id" {
  value = (
    var.create_backup_storage
    ? azurerm_storage_account.cdp_storage_locations[local.resolved_backup_storage_account].id
    : data.azurerm_storage_account.existing_storage[var.existing_backup_storage_account].id
  )
  description = "Azure backup storage account ID"
}

output "azure_backup_storage_account_primary_dfs_endpoint" {
  value = (
    var.create_backup_storage
    ? azurerm_storage_account.cdp_storage_locations[local.resolved_backup_storage_account].primary_dfs_endpoint
    : data.azurerm_storage_account.existing_storage[var.existing_backup_storage_account].primary_dfs_endpoint
  )
  description = "Azure backup storage account primary DFS endpoint"
}

output "azure_backup_storage_container_id" {
  value = (
    var.create_backup_storage
    ? azurerm_storage_container.cdp_backup_storage[0].id
    : data.azurerm_storage_container.existing_backup_storage[0].id
  )
  description = "Azure backup storage container ID"
}

# ------- Aggregate Outputs -------
output "storage_account_ids" {
  value = merge(
    { for k, v in azurerm_storage_account.cdp_storage_locations : k => v.id },
    { for k, v in data.azurerm_storage_account.existing_storage : k => v.id }
  )
  description = "Map of storage account names to their IDs (created and pre-existing)"
}
