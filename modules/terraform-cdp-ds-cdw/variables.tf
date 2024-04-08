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

# ------- Global settings -------
variable "infra_type" {
  type        = string
  description = "Cloud Provider to deploy CDP."

  validation {
    condition     = contains(["aws", "azure"], var.infra_type)
    error_message = "Valid values for var: infra_type are (azure, aws)."
  }
}

variable "env_tags" {
  type        = map(any)
  description = "Tags applied to provisioned resources"

  default = null
}

variable "agent_source_tag" {
  type        = map(any)
  description = "Tag to identify deployment source"

  default = { agent_source = "tf-cdp-module" }
}

variable "env_prefix" {
  type        = string
  description = "Shorthand name for the environment. Used in CDP resource descriptions. This will be used to construct the value of where any of the CDP resource variables (e.g. environment_name, cdp_iam_admin_group_name) are not defined."

}

# ------- CDP Settings - General -------
variable "cdp_environment_name" {
  type        = string
  description = "Name of the CDP environment. Defaults to '<env_prefix>-cdp-env' if not specified."

}

# ------- Cloud Settings - General -------
variable "region" {
  type        = string
  description = "Region which cloud resources will be created"

}

# ------- Azure specific settings -------
variable "azure_resource_group_name" {
  type        = string
  description = "Azrue Resource Group for CDP environment."

  default = null
}

variable "azure_aks_credential_managed_identity_name" {
    type = string

    description = "Name of the Managed Identity for the AKS Credential"

    default = null
}

variable "cdw_aks_cred_role_assignments" {
  type = list(object({
    role        = string
    description = optional(string)
    })
  )

  description = "List of Role Assignments for the AKS Credential"

  default = [
    {
      "description" : "Assign Contributor Role to AKS Credential",
      "role" : "Contributor"
    }
  ]

}