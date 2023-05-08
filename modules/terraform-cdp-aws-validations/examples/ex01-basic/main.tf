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

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

module "ex01_basic" {
  source = "../.."

  aws_region = var.aws_region

}


output "vpcs_per_region_quota" {
  value = module.ex01_basic.aws_vpc_quota.value
}

output "vpcs_per_region_usage" {
  value = module.ex01_basic.aws_vpc_usage
}