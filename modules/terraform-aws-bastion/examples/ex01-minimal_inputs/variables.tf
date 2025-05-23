# Copyright 2025 Cloudera, Inc. All Rights Reserved.
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

# ------- Global settings -------
variable "name_prefix" {
  type        = string
  description = "Shorthand name to use when naming resources."
}

# ------- Cloud Settings -------
variable "aws_region" {
  type        = string
  description = "Region which Cloud resources will be created"
}

variable "aws_key_pair" {
  type        = string
  description = "Name of the Public SSH key for the CDP environment"
}

# ------- Bastion settings -------
variable "ingress_extra_cidrs" {
  type        = list(string)
  description = "List of extra ingress rules to create."

  default = []
}