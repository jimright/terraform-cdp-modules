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

# ------- Create or Reuse Flags -------
variable "create_data_storage" {
  type        = bool
  description = "Create a new S3 bucket for data storage. When false, an existing bucket is looked up via existing_data_storage_bucket."

  default = true
}

variable "create_log_storage" {
  type        = bool
  description = "Create a new S3 bucket for log storage. When false, an existing bucket is looked up via existing_log_storage_bucket."

  default = true
}

variable "create_backup_storage" {
  type        = bool
  description = "Create a new S3 bucket for backup storage. When false, an existing bucket is looked up via existing_backup_storage_bucket."

  default = true
}

# ------- Storage Role: Data -------
variable "data_storage_bucket" {
  type        = string
  description = "Name of the S3 bucket for data storage. Required when create_data_storage is true."

  default = null

  validation {
    condition     = var.data_storage_bucket == null || (length(var.data_storage_bucket) >= 3 && length(var.data_storage_bucket) <= 63)
    error_message = "The length of data_storage_bucket must be between 3 and 63 characters."
  }

  validation {
    condition     = var.data_storage_bucket == null || can(regex("^[a-z0-9\\-\\.]{1,64}$", var.data_storage_bucket))
    error_message = "data_storage_bucket can consist only of lowercase letters, numbers, dots (.), and hyphens (-)."
  }
}

variable "data_storage_object" {
  type        = string
  description = "Path for the data storage object/folder within the bucket"

  default = "data/"
}

# ------- Storage Role: Log -------
variable "log_storage_bucket" {
  type        = string
  description = "Name of the S3 bucket for log storage. Required when create_log_storage is true."

  default = null

  validation {
    condition     = var.log_storage_bucket == null || (length(var.log_storage_bucket) >= 3 && length(var.log_storage_bucket) <= 63)
    error_message = "The length of log_storage_bucket must be between 3 and 63 characters."
  }

  validation {
    condition     = var.log_storage_bucket == null || can(regex("^[a-z0-9\\-\\.]{1,64}$", var.log_storage_bucket))
    error_message = "log_storage_bucket can consist only of lowercase letters, numbers, dots (.), and hyphens (-)."
  }
}

variable "log_storage_object" {
  type        = string
  description = "Path for the log storage object/folder within the bucket"

  default = "logs/"
}

# ------- Storage Role: Backup -------
variable "backup_storage_bucket" {
  type        = string
  description = "Name of the S3 bucket for backup storage. Required when create_backup_storage is true."

  default = null

  validation {
    condition     = var.backup_storage_bucket == null || (length(var.backup_storage_bucket) >= 3 && length(var.backup_storage_bucket) <= 63)
    error_message = "The length of backup_storage_bucket must be between 3 and 63 characters."
  }

  validation {
    condition     = var.backup_storage_bucket == null || can(regex("^[a-z0-9\\-\\.]{1,64}$", var.backup_storage_bucket))
    error_message = "backup_storage_bucket can consist only of lowercase letters, numbers, dots (.), and hyphens (-)."
  }
}

variable "backup_storage_object" {
  type        = string
  description = "Path for the backup storage object/folder within the bucket"

  default = "backups/"
}

# ------- Existing Bucket References -------
variable "existing_data_storage_bucket" {
  type        = string
  description = "Name of an existing S3 bucket for data storage. Required when create_data_storage is false."

  default = null
}

variable "existing_log_storage_bucket" {
  type        = string
  description = "Name of an existing S3 bucket for log storage. Required when create_log_storage is false."

  default = null
}

variable "existing_backup_storage_bucket" {
  type        = string
  description = "Name of an existing S3 bucket for backup storage. Required when create_backup_storage is false."

  default = null
}

# ------- Storage Suffix -------
variable "storage_suffix" {
  type        = string
  description = "Suffix to append to bucket names for uniqueness. Passed from parent module. Only applied to created buckets."

  default = ""
}

# ------- Tags -------
variable "tags" {
  type        = map(string)
  description = "Tags to apply to created resources"

  default = {}
}

# ------- Ancillary Resource Flags (applied to created buckets only) -------
variable "enable_public_access_block" {
  type        = bool
  description = "Apply S3 public access block to created buckets. Has no effect on reused buckets."

  default = true
}

variable "enable_bucket_versioning" {
  type        = bool
  description = "Enable versioning on created buckets. Has no effect on reused buckets."

  default = false
}

variable "kms_key_arn" {
  type        = string
  description = "ARN of an existing KMS key to use for bucket encryption on created buckets. Has no effect on reused buckets. If null, no KMS encryption is applied."

  default = null
}

# ------- Bucket Lifecycle -------
variable "force_destroy" {
  type        = bool
  description = "Allow created buckets to be destroyed even when they contain objects"

  default = true
}
