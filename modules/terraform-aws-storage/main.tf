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

# ------- S3 Buckets -------
resource "aws_s3_bucket" "cdp_storage_locations" {
  for_each = local.unique_buckets

  bucket = "${each.value}${var.storage_suffix}"
  tags   = merge(var.tags, { Name = "${each.value}${var.storage_suffix}" })

  force_destroy = var.force_destroy
}

# ------- Public Access Block -------
resource "aws_s3_bucket_public_access_block" "cdp_storage_locations" {
  for_each = var.enable_public_access_block ? aws_s3_bucket.cdp_storage_locations : {}

  bucket = each.value.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ------- KMS Encryption -------
resource "aws_s3_bucket_server_side_encryption_configuration" "cdp_storage_location_kms" {
  for_each = var.kms_key_arn != null ? aws_s3_bucket.cdp_storage_locations : {}

  bucket = each.value.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# ------- Bucket Versioning -------
resource "aws_s3_bucket_versioning" "cdp_storage_location_versioning" {
  for_each = var.enable_bucket_versioning ? aws_s3_bucket.cdp_storage_locations : {}

  bucket = each.value.id

  versioning_configuration {
    status = "Enabled"
  }
}

# ------- Folder Objects -------
# Note: Data storage object is not created because CDP overrides this
resource "aws_s3_object" "cdp_log_storage_object" {

  bucket = aws_s3_bucket.cdp_storage_locations[var.log_storage_bucket].id

  key          = var.log_storage_object
  content_type = "application/x-directory"
}

resource "aws_s3_object" "cdp_backup_storage_object" {

  bucket = aws_s3_bucket.cdp_storage_locations[var.backup_storage_bucket].id

  key          = var.backup_storage_object
  content_type = "application/x-directory"
}
