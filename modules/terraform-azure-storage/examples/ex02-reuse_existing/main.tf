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

provider "azurerm" {
  features {}
}

module "azure_storage" {
  source = "../.."

  # Data: reuse an existing storage account and container
  create_data_storage             = false
  existing_data_storage_account   = var.existing_data_storage_account
  existing_data_storage_container = var.existing_data_storage_container

  # Log: create a new storage account
  create_log_storage    = true
  log_storage_account   = var.log_storage_account
  log_storage_container = var.log_storage_container

  # Backup: reuse an existing storage account and container
  create_backup_storage             = false
  existing_backup_storage_account   = var.existing_backup_storage_account
  existing_backup_storage_container = var.existing_backup_storage_container

  resource_group_name = var.resource_group_name
  location            = var.azure_region

  storage_suffix = var.storage_suffix

  tags = var.tags
}
