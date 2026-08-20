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

# ------- Data Storage -------
output "aws_data_storage_bucket" {
  value       = local.data_bucket_name
  description = "AWS data storage bucket name"
}

output "aws_data_storage_object" {
  value       = var.data_storage_object
  description = "AWS data storage object path"
}

output "aws_data_storage_location" {
  value       = "s3a://${local.data_bucket_name}/${var.data_storage_object}"
  description = "AWS data storage location (s3a:// URI)"
}

output "aws_data_storage_bucket_arn" {
  value       = aws_s3_bucket.cdp_storage_locations[var.data_storage_bucket].arn
  description = "AWS data storage bucket ARN"
}

output "aws_data_storage_bucket_id" {
  value       = aws_s3_bucket.cdp_storage_locations[var.data_storage_bucket].id
  description = "AWS data storage bucket ID"
}

# ------- Log Storage -------
output "aws_log_storage_bucket" {
  value       = local.log_bucket_name
  description = "AWS log storage bucket name"
}

output "aws_log_storage_object" {
  value       = var.log_storage_object
  description = "AWS log storage object path"
}

output "aws_log_storage_location" {
  value       = "s3a://${local.log_bucket_name}/${var.log_storage_object}"
  description = "AWS log storage location (s3a:// URI)"
}

output "aws_log_storage_bucket_arn" {
  value       = aws_s3_bucket.cdp_storage_locations[var.log_storage_bucket].arn
  description = "AWS log storage bucket ARN"
}

output "aws_log_storage_bucket_id" {
  value       = aws_s3_bucket.cdp_storage_locations[var.log_storage_bucket].id
  description = "AWS log storage bucket ID"
}

# ------- Backup Storage -------
output "aws_backup_storage_bucket" {
  value       = local.backup_bucket_name
  description = "AWS backup storage bucket name"
}

output "aws_backup_storage_object" {
  value       = var.backup_storage_object
  description = "AWS backup storage object path"
}

output "aws_backup_storage_location" {
  value       = "s3a://${local.backup_bucket_name}/${var.backup_storage_object}"
  description = "AWS backup storage location (s3a:// URI)"
}

output "aws_backup_storage_bucket_arn" {
  value       = aws_s3_bucket.cdp_storage_locations[var.backup_storage_bucket].arn
  description = "AWS backup storage bucket ARN"
}

output "aws_backup_storage_bucket_id" {
  value       = aws_s3_bucket.cdp_storage_locations[var.backup_storage_bucket].id
  description = "AWS backup storage bucket ID"
}
