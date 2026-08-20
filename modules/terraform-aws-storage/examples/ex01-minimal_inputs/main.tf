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

provider "aws" {
  region = var.aws_region
}

resource "random_id" "bucket_suffix" {
  count       = var.random_id_for_bucket ? 1 : 0
  byte_length = 4
}

locals {
  storage_suffix = var.random_id_for_bucket ? "-${one(random_id.bucket_suffix).hex}" : ""
}

module "aws_storage" {
  source = "../.."

  data_storage_bucket   = var.data_storage_bucket
  data_storage_object   = var.data_storage_object
  log_storage_bucket    = var.log_storage_bucket
  log_storage_object    = var.log_storage_object
  backup_storage_bucket = var.backup_storage_bucket
  backup_storage_object = var.backup_storage_object

  storage_suffix = local.storage_suffix

  tags = var.tags

  enable_public_access_block = var.enable_public_access_block
  enable_bucket_versioning   = var.enable_bucket_versioning
  kms_key_arn                = var.kms_key_arn
}
