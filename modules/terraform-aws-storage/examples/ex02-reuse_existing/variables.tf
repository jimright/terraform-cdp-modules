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

variable "existing_data_storage_bucket" {
  type        = string
  description = "Name of an existing S3 bucket for data storage"
}

variable "log_storage_bucket" {
  type        = string
  description = "Name of the S3 bucket to create for log storage"
}

variable "log_storage_object" {
  type        = string
  description = "Path for the log storage object"
  default     = "logs/"
}

variable "existing_backup_storage_bucket" {
  type        = string
  description = "Name of an existing S3 bucket for backup storage"
}

variable "storage_suffix" {
  type        = string
  description = "Suffix for created bucket names"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
