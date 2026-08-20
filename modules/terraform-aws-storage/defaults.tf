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

  # Deduplicated set of bucket names to create
  buckets_to_create = toset([for name in [
    var.create_data_storage ? var.data_storage_bucket : null,
    var.create_log_storage ? var.log_storage_bucket : null,
    var.create_backup_storage ? var.backup_storage_bucket : null,
  ] : name if name != null])

  # Deduplicated set of existing bucket names to look up
  buckets_to_lookup = toset([for name in [
    var.create_data_storage ? null : var.existing_data_storage_bucket,
    var.create_log_storage ? null : var.existing_log_storage_bucket,
    var.create_backup_storage ? null : var.existing_backup_storage_bucket,
  ] : name if name != null])

  # Fully qualified bucket names per role (consistent regardless of create/reuse)
  data_bucket_name   = var.create_data_storage ? "${var.data_storage_bucket}${var.storage_suffix}" : var.existing_data_storage_bucket
  log_bucket_name    = var.create_log_storage ? "${var.log_storage_bucket}${var.storage_suffix}" : var.existing_log_storage_bucket
  backup_bucket_name = var.create_backup_storage ? "${var.backup_storage_bucket}${var.storage_suffix}" : var.existing_backup_storage_bucket
}
