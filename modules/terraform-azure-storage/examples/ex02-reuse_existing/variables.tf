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

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group for storage accounts"
}

variable "azure_region" {
  type        = string
  description = "Region which Cloud resources will be created"
}

variable "existing_data_storage_account" {
  type        = string
  description = "Name of an existing storage account for data storage"
}

variable "existing_data_storage_container" {
  type        = string
  description = "Name of an existing container for data storage"
}

variable "log_storage_account" {
  type        = string
  description = "Name of the storage account for log storage"
}

variable "log_storage_container" {
  type        = string
  description = "Name of the log storage container"
  default     = "logs"
}

variable "existing_backup_storage_account" {
  type        = string
  description = "Name of an existing storage account for backup storage"
}

variable "existing_backup_storage_container" {
  type        = string
  description = "Name of an existing container for backup storage"
}

variable "storage_suffix" {
  type        = string
  description = "Suffix to append to created storage account names"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
