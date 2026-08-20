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

# ------- Create or Reuse Flags -------
variable "create_data_storage" {
  type        = bool
  description = "Create a new storage account for data storage. When false, an existing account is looked up via existing_data_storage_account."

  default = true
}

variable "create_log_storage" {
  type        = bool
  description = "Create a new storage account for log storage. When false, an existing account is looked up via existing_log_storage_account."

  default = true
}

variable "create_backup_storage" {
  type        = bool
  description = "Create a new storage account for backup storage. When false, an existing account is looked up via existing_backup_storage_account."

  default = true
}

# ------- Storage Role: Data -------
variable "data_storage_account" {
  type        = string
  description = "Name of the storage account for data storage. Required when create_data_storage is true."

  default = null

  validation {
    condition     = var.data_storage_account == null || (length(var.data_storage_account) >= 3 && length(var.data_storage_account) <= 24)
    error_message = "The length of data_storage_account must be between 3 and 24 characters."
  }

  validation {
    condition     = var.data_storage_account == null || can(regex("^[a-z0-9]{1,24}$", var.data_storage_account))
    error_message = "data_storage_account can consist only of lowercase letters and numbers."
  }
}

variable "data_storage_container" {
  type        = string
  description = "Name of the container for data storage"

  default = "data"
}

# ------- Storage Role: Log -------
variable "log_storage_account" {
  type        = string
  description = "Name of the storage account for log storage. Required when create_log_storage is true. Defaults to data_storage_account if null."

  default = null

  validation {
    condition     = var.log_storage_account == null || (length(var.log_storage_account) >= 3 && length(var.log_storage_account) <= 24)
    error_message = "The length of log_storage_account must be between 3 and 24 characters."
  }

  validation {
    condition     = var.log_storage_account == null || can(regex("^[a-z0-9]{1,24}$", var.log_storage_account))
    error_message = "log_storage_account can consist only of lowercase letters and numbers."
  }
}

variable "log_storage_container" {
  type        = string
  description = "Name of the container for log storage"

  default = "logs"
}

# ------- Storage Role: Backup -------
variable "backup_storage_account" {
  type        = string
  description = "Name of the storage account for backup storage. Required when create_backup_storage is true. Defaults to data_storage_account if null."

  default = null

  validation {
    condition     = var.backup_storage_account == null || (length(var.backup_storage_account) >= 3 && length(var.backup_storage_account) <= 24)
    error_message = "The length of backup_storage_account must be between 3 and 24 characters."
  }

  validation {
    condition     = var.backup_storage_account == null || can(regex("^[a-z0-9]{1,24}$", var.backup_storage_account))
    error_message = "backup_storage_account can consist only of lowercase letters and numbers."
  }
}

variable "backup_storage_container" {
  type        = string
  description = "Name of the container for backup storage"

  default = "backups"
}

# ------- Existing Storage Account References -------
variable "existing_data_storage_account" {
  type        = string
  description = "Name of an existing storage account for data storage. Required when create_data_storage is false."

  default = null
}

variable "existing_data_storage_container" {
  type        = string
  description = "Name of an existing container for data storage. Required when create_data_storage is false."

  default = null
}

variable "existing_log_storage_account" {
  type        = string
  description = "Name of an existing storage account for log storage. Required when create_log_storage is false."

  default = null
}

variable "existing_log_storage_container" {
  type        = string
  description = "Name of an existing container for log storage. Required when create_log_storage is false."

  default = null
}

variable "existing_backup_storage_account" {
  type        = string
  description = "Name of an existing storage account for backup storage. Required when create_backup_storage is false."

  default = null
}

variable "existing_backup_storage_container" {
  type        = string
  description = "Name of an existing container for backup storage. Required when create_backup_storage is false."

  default = null
}

# ------- Resource Group -------
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where storage accounts will be created or looked up"
}

variable "location" {
  type        = string
  description = "Azure region for created storage accounts"
}

# ------- Storage Suffix -------
variable "storage_suffix" {
  type        = string
  description = "Suffix to append to storage account names for uniqueness. Only applied to created accounts."

  default = ""
}

# ------- Storage Account Configuration -------
variable "account_kind" {
  type        = string
  description = "Kind of storage account (StorageV2, BlobStorage, etc.)"

  default = "StorageV2"
}

variable "account_tier" {
  type        = string
  description = "Performance tier of the storage account (Standard or Premium)"

  default = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "Replication type for the storage account (LRS, GRS, RAGRS, ZRS)"

  default = "LRS"
}

# ------- Network Rules -------
variable "create_network_rules" {
  type        = bool
  description = "Enable creation of network rules for created storage accounts"

  default = false
}

variable "network_rules_default_action" {
  type        = string
  description = "Default action for network rules (Allow or Deny)"

  default = "Deny"

  validation {
    condition     = contains(["Allow", "Deny"], var.network_rules_default_action)
    error_message = "Valid values for network_rules_default_action are (Allow, Deny)."
  }
}

variable "network_rules_bypass" {
  type        = list(string)
  description = "List of services to bypass network rules (e.g. AzureServices, Logging, Metrics)"

  default = ["AzureServices"]
}

variable "network_rules_ip_rules" {
  type        = list(string)
  description = "List of IP CIDR ranges to allow through network rules"

  default = []
}

variable "network_rules_subnet_ids" {
  type        = list(string)
  description = "List of virtual network subnet IDs to allow through network rules"

  default = []
}

# ------- Public Network Access -------
variable "public_network_access_enabled" {
  type        = bool
  description = "Enable public network access on created storage accounts"

  default = true
}

# ------- Tags -------
variable "tags" {
  type        = map(string)
  description = "Tags to apply to created resources"

  default = {}
}
