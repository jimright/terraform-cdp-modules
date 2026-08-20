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

resource "random_id" "bucket_suffix" {
  count       = var.random_id_for_bucket ? 1 : 0
  byte_length = 4
}

locals {
  storage_suffix = var.random_id_for_bucket ? one(random_id.bucket_suffix).hex : ""
}

# ------- Azure Resource Group -------
module "rmgp" {
  source = "../../../terraform-azure-resource-group"

  resourcegroup_name = "${var.env_prefix}-rg"
  azure_region       = var.azure_region

  tags = merge(var.env_tags, { Name = "${var.env_prefix}-rg" })
}


# ------- Azure Storage -------
module "azure_storage" {
  source = "../.."

  data_storage_account   = "${var.env_prefix}stor"
  data_storage_container = var.data_storage_container

  log_storage_account   = "${var.env_prefix}stor"
  log_storage_container = var.log_storage_container

  backup_storage_account   = "${var.env_prefix}stor"
  backup_storage_container = var.backup_storage_container

  resource_group_name = module.rmgp.resource_group_name
  location            = var.azure_region

  storage_suffix = local.storage_suffix

  tags = var.env_tags
}
