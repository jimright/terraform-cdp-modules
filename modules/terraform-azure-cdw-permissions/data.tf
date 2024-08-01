# Copyright 2024 Cloudera, Inc. All Rights Reserved.
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

# Access information about Azure Subscription
data "azurerm_subscription" "current" {}

# Find details of the Azure Resource group
data "azurerm_resource_group" "cdp_ds_rmgp" {
  name = var.azure_resource_group_name
}

# Find details about the data storage account
data "azurerm_storage_account" "data_storage_account" {
  name                = var.azure_data_storage_account
  resource_group_name = var.azure_resource_group_name
}