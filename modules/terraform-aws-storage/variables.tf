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

# ------- Storage Role: Data -------
variable "data_storage_bucket" {
  type        = string
  description = "Name of the S3 bucket for data storage"

  validation {
    condition     = length(var.data_storage_bucket) >= 3 && length(var.data_storage_bucket) <= 63
    error_message = "The length of data_storage_bucket must be between 3 and 63 characters."
  }

  validation {
    condition     = can(regex("^[a-z0-9\\-\\.]{1,64}$", var.data_storage_bucket))
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
  description = "Name of the S3 bucket for log storage"

  validation {
    condition     = length(var.log_storage_bucket) >= 3 && length(var.log_storage_bucket) <= 63
    error_message = "The length of log_storage_bucket must be between 3 and 63 characters."
  }

  validation {
    condition     = can(regex("^[a-z0-9\\-\\.]{1,64}$", var.log_storage_bucket))
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
  description = "Name of the S3 bucket for backup storage"

  validation {
    condition     = length(var.backup_storage_bucket) >= 3 && length(var.backup_storage_bucket) <= 63
    error_message = "The length of backup_storage_bucket must be between 3 and 63 characters."
  }

  validation {
    condition     = can(regex("^[a-z0-9\\-\\.]{1,64}$", var.backup_storage_bucket))
    error_message = "backup_storage_bucket can consist only of lowercase letters, numbers, dots (.), and hyphens (-)."
  }
}

variable "backup_storage_object" {
  type        = string
  description = "Path for the backup storage object/folder within the bucket"

  default = "backups/"
}

# ------- Storage Suffix -------
variable "storage_suffix" {
  type        = string
  description = "Suffix to append to bucket names for uniqueness. Passed from parent module."

  default = ""
}

# ------- Tags -------
variable "tags" {
  type        = map(string)
  description = "Tags to apply to created resources"

  default = {}
}

# ------- Ancillary Resource Flags -------
variable "enable_public_access_block" {
  type        = bool
  description = "Apply S3 public access block to created buckets"

  default = true
}

variable "enable_bucket_versioning" {
  type        = bool
  description = "Enable versioning on created buckets"

  default = false
}

variable "kms_key_arn" {
  type        = string
  description = "ARN of an existing KMS key to use for bucket encryption. If null, no KMS encryption is applied."

  default = null
}

# ------- Bucket Lifecycle -------
variable "force_destroy" {
  type        = bool
  description = "Allow buckets to be destroyed even when they contain objects"

  default = true
}
