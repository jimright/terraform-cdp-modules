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

data "aws_servicequotas_service_quota" "vpcs_per_region" {
  quota_name   = "VPCs per Region"
  service_code = "vpc"

  lifecycle {
    postcondition {
      condition = self.value < data.external.aws_vpc_usage_check.result.created_vpcs_per_region
      error_message = "${var.vpc_count_required} VPCs are required for this CDP deployment"

    }
  }
}

data "external" "aws_vpc_usage_check" {

  program = ["bash", "${path.module}/run_aws_resource_usage_check.sh"]
  query = {
    region = var.aws_region
  }
}

# NOTE: WIP, alternative to above without bash wrapper
# data "external" "aws_vpc_usage_check" {

#    program = ["sh", "-c", "aws", "ec2", "describe-vpcs", "--region", "${var.aws_region}", "| jq -r '.Vpcs | length"]
# #   aws ec2 describe-vpcs --region $aws_region | jq '.Vpcs | length
# }
