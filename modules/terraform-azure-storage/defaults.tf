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

locals {

  # Resolve account names per role (log/backup default to data account if null, but only when creating)
  resolved_data_storage_account   = var.create_data_storage ? var.data_storage_account : null
  resolved_log_storage_account    = var.create_log_storage ? try(coalesce(var.log_storage_account, var.data_storage_account), var.log_storage_account) : null
  resolved_backup_storage_account = var.create_backup_storage ? try(coalesce(var.backup_storage_account, var.data_storage_account), var.backup_storage_account) : null

  # Deduplicated set of storage account names to create
  accounts_to_create = toset([for name in [
    var.create_data_storage ? local.resolved_data_storage_account : null,
    var.create_log_storage ? local.resolved_log_storage_account : null,
    var.create_backup_storage ? local.resolved_backup_storage_account : null,
  ] : name if name != null])

  # Deduplicated set of existing storage account names to look up
  accounts_to_lookup = toset([for name in [
    var.create_data_storage ? null : var.existing_data_storage_account,
    var.create_log_storage ? null : var.existing_log_storage_account,
    var.create_backup_storage ? null : var.existing_backup_storage_account,
  ] : name if name != null])

  # Fully qualified account names per role (consistent regardless of create/reuse)
  data_account_name   = var.create_data_storage ? "${local.resolved_data_storage_account}${var.storage_suffix}" : var.existing_data_storage_account
  log_account_name    = var.create_log_storage ? "${local.resolved_log_storage_account}${var.storage_suffix}" : var.existing_log_storage_account
  backup_account_name = var.create_backup_storage ? "${local.resolved_backup_storage_account}${var.storage_suffix}" : var.existing_backup_storage_account

  # Container names per role
  data_container_name   = var.create_data_storage ? var.data_storage_container : var.existing_data_storage_container
  log_container_name    = var.create_log_storage ? var.log_storage_container : var.existing_log_storage_container
  backup_container_name = var.create_backup_storage ? var.backup_storage_container : var.existing_backup_storage_container
}
