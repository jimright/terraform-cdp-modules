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

# ------- Global settings -------
variable "env_prefix" {
  type        = string
  description = "Shorthand name for the environment. Used in resource descriptions"
}

variable "azure_region" {
  type        = string
  description = "Region which Cloud resources will be created"
}

variable "env_tags" {
  type        = map(any)
  description = "Tags applied to provised resources"

  default = null
}

# variable "data_storage_account" {
#   type        = string
#   description = "Name of the storage account for data storage"
# }

variable "data_storage_container" {
  type        = string
  description = "Name of the data storage container"
  default     = "data"
}

# variable "log_storage_account" {
#   type        = string
#   description = "Name of the storage account for log storage. Defaults to data_storage_account."
#   default     = null
# }

variable "log_storage_container" {
  type        = string
  description = "Name of the log storage container"
  default     = "logs"
}

# variable "backup_storage_account" {
#   type        = string
#   description = "Name of the storage account for backup storage. Defaults to data_storage_account."
#   default     = null
# }

variable "backup_storage_container" {
  type        = string
  description = "Name of the backup storage container"
  default     = "backups"
}

variable "random_id_for_bucket" {
  type        = bool
  description = "Create a random suffix for the storage account names"
  default     = true
}
