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

output "aws_data_storage_location" {
  value       = module.aws_storage.aws_data_storage_location
  description = "AWS data storage location (s3a:// URI)"
}

output "aws_log_storage_location" {
  value       = module.aws_storage.aws_log_storage_location
  description = "AWS log storage location (s3a:// URI)"
}

output "aws_backup_storage_location" {
  value       = module.aws_storage.aws_backup_storage_location
  description = "AWS backup storage location (s3a:// URI)"
}
