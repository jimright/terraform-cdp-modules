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
variable "tags" {
  type        = map(any)
  description = "Tags applied to provisioned resources"

  default = {}
}

# ------- Firewall Rule Groups -------
# Rule group for CDP deployment
variable "cdp_fw_rule_group_capacity" {
  type        = number
  description = "Capacity (maximum number of operating resources) for the CDP Firewall Rule Group"

  default = 300
}

variable "cdp_firewall_rule_group_name" {
  type = string

  description = "Name of the CDP Rule Group."

  validation {
    condition     = (length(var.cdp_firewall_rule_group_name) >= 1 && length(var.cdp_firewall_rule_group_name) <= 64)
    error_message = "The length of cdp_firewall_rule_group_name must be between 1 and 64 characters."
  }
}

variable "cdp_firewall_domain_allowlist" {
  type = list(string)

  description = "Domain allowlist for CDP Rule Group."

  default = [
    "cloudera.com"
  ]
}

# TODO: Other rule groups?

# ------- Firewall Policies -------
variable "firewall_policy_name" {
  type = string

  description = "Name of the Firewall Policy."

  validation {
    condition     = (length(var.firewall_policy_name) >= 1 && length(var.firewall_policy_name) <= 128)
    error_message = "The length of firewall_policy_name must be between 1 and 128 characters."
  }
}

# ------- Firewall -------
variable "firewall_name" {
  type = string

  description = "Name of the Firewall."

  validation {
    condition     = (length(var.firewall_name) >= 1 && length(var.firewall_name) <= 256)
    error_message = "The length of firewall_name must be between 1 and 256 characters."
  }
}

variable "firewall_subnet_ids" {
  type = list(string)

  description = "List of subnet ids to assign to the Firewall."
}


# ------- Logging Config -------
variable "firewall_logging_config" {
  description = "Logging config for cloudwatch logs created for network Firewall"
  type        = map(any)

  # NOTE: Stricter type definition below didn't work
  # type        = map(object({
  #   alert = optional(object({
  #     retention_in_days = optional(number)
  #     log_group_class   = optional(string)
  #   }))
  #   flow = optional(object({
  #     retention_in_days = optional(number)
  #     log_group_class   = optional(string)
  #   }))
  #   tls = optional(object({
  #     retention_in_days = optional(number)
  #     log_group_class   = optional(string)
  #   }))
  # })
  # )
  default = {
    alert = {
      retention_in_days = 3
    }
    flow = {
      retention_in_days = 1
    }
  }
}

# ------- VPC and Network Settings -------
variable "cdp_vpc_id" {
  type        = string
  description = "VPC ID for where the CDP environment is running"
}

variable "network_vpc_id" {
  type        = string
  description = "VPC ID for where the Networking components are running"
}

# ------- Route table updates -------
variable "route_tables_to_update" {
  description = "List of any route tables to update to target the Firewall Endpoint"
  type = list(object({
    route_tables           = list(string)
    availability_zones     = optional(list(string))
    destination_cidr_block = string
  }))

  default = []
}
