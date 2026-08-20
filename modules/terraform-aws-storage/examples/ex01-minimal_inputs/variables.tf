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

variable "aws_region" {
  type        = string
  description = "AWS region for resources"
}

variable "random_id_for_bucket" {
  type        = bool
  description = "Create a random suffix for the bucket names"
  default     = true
}

variable "data_storage_bucket" {
  type        = string
  description = "Name of the S3 bucket for data storage"
}

variable "data_storage_object" {
  type        = string
  description = "Path for the data storage object"
  default     = "data/"
}

variable "log_storage_bucket" {
  type        = string
  description = "Name of the S3 bucket for log storage"
}

variable "log_storage_object" {
  type        = string
  description = "Path for the log storage object"
  default     = "logs/"
}

variable "backup_storage_bucket" {
  type        = string
  description = "Name of the S3 bucket for backup storage"
}

variable "backup_storage_object" {
  type        = string
  description = "Path for the backup storage object"
  default     = "backups/"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}

variable "enable_public_access_block" {
  type        = bool
  description = "Apply S3 public access block to created buckets"
  default     = true
}

variable "enable_bucket_versioning" {
  type        = bool
  description = "Enable versioning on created buckets"
  default     = false
}

variable "kms_key_arn" {
  type        = string
  description = "ARN of an existing KMS key for bucket encryption"
  default     = null
}
