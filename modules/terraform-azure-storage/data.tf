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

# ------- Data Sources for Existing Storage Accounts -------
data "azurerm_storage_account" "existing_storage" {
  for_each = local.accounts_to_lookup

  name                = each.value
  resource_group_name = var.resource_group_name
}

# ------- Data Sources for Existing Storage Containers -------
data "azurerm_storage_container" "existing_data_storage" {
  count = var.create_data_storage ? 0 : 1

  name               = var.existing_data_storage_container
  storage_account_id = data.azurerm_storage_account.existing_storage[var.existing_data_storage_account].id
}

data "azurerm_storage_container" "existing_log_storage" {
  count = var.create_log_storage ? 0 : 1

  name               = var.existing_log_storage_container
  storage_account_id = data.azurerm_storage_account.existing_storage[var.existing_log_storage_account].id
}

data "azurerm_storage_container" "existing_backup_storage" {
  count = var.create_backup_storage ? 0 : 1

  name               = var.existing_backup_storage_container
  storage_account_id = data.azurerm_storage_account.existing_storage[var.existing_backup_storage_account].id
}
