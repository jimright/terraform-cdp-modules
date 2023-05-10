# Copyright 2023 Cloudera, Inc. All Rights Reserved.
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

# CDP environment & DL settings
output "aws_vpc_quota" {
  value = data.aws_servicequotas_service_quota.vpcs_per_region

  description = "VPC Per Region Quota"
}

output "aws_vpc_usage" {
  value = data.external.aws_vpc_usage_check.result

  description = "VPC Per Region Usage"
}

output "cdp_quota_validation_checks" {
  value = data.external.quota_validation_checks.result

  description = "Quota Validation" 
}