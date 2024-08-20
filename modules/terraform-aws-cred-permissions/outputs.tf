# Copyright 2024 Cloudera, Inc. All Rights Reserved.
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

output "aws_xaccount_role_arn" {
  value = local.create_xaccount_resources ? aws_iam_role.cdp_xaccount_role[0].arn : data.aws_iam_role.existing_xaccount_role[0].arn

  description = "Cross Account role ARN"
}

output "aws_xaccount_role_name" {
  value = local.create_xaccount_resources ? aws_iam_role.cdp_xaccount_role[0].name : data.aws_iam_role.existing_xaccount_role[0].name

  description = "Cross Account role name"
}