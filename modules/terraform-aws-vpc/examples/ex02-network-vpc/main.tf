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
  region = var.aws_region
}

module "ex01_network_vpc" {
  source = "../.."

  cdp_vpc            = false
  vpc_name           = var.vpc_name
  vpc_cidr           = var.vpc_cidr
  enable_nat_gateway = var.enable_nat_gateway

  tags = var.env_tags

  private_cidr_range = var.private_cidr_range
  public_cidr_range  = var.public_cidr_range

}
