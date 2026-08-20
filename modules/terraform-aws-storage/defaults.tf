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

  # Fully qualified bucket names (with suffix)
  data_bucket_name   = "${var.data_storage_bucket}${var.storage_suffix}"
  log_bucket_name    = "${var.log_storage_bucket}${var.storage_suffix}"
  backup_bucket_name = "${var.backup_storage_bucket}${var.storage_suffix}"

  # Deduplicated set of bucket base names for resource creation
  unique_buckets = toset([var.data_storage_bucket, var.log_storage_bucket, var.backup_storage_bucket])
}
