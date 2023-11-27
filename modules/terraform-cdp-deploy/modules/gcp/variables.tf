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
# NOTE: Waiting on provider fix
# variable "tags" {
#   type        = map(any)
#   description = "Tags applied to provisioned resources"

# }

# ------- CDP Environment Deployment -------
variable "environment_name" {
  type        = string
  description = "Name of the CDP environment."

}

variable "datalake_name" {
  type        = string
  description = "Name of the CDP DataLake."

}

variable "cdp_xacccount_credential_name" {
  type        = string
  description = "Name of the CDP Cross Account Credential."

}

variable "cdp_admin_group_name" {
  type        = string
  description = "Name of the CDP IAM Admin Group associated with the environment."

}

variable "cdp_user_group_name" {
  type        = string
  description = "Name of the CDP IAM User Group associated with the environment."

}

variable "enable_ccm_tunnel" {
  type = bool

  description = "Flag to enable Cluster Connectivity Manager tunnel. If false then access from Cloud to CDP Control Plane CIDRs is required from via SG ingress"

}

variable "report_deployment_logs" {
  type = bool

  description = "Flag to enable reporting of additional diagnostic information back to Cloudera"
  
}

variable "environment_polling_timeout" {
  type = number

  description = " Timeout value in minutes for how long to poll for CDP Environment resource creation/deletion"

}

variable "freeipa_instances" {
  type = number

  description = "The number of FreeIPA instances to create in the environment"

}

variable "freeipa_instance_type" {
  type = string

  description = "Instance Type to use for creating FreeIPA instances"

}

variable "freeipa_recipes" {
  type = set(string)

  description = "The recipes for the FreeIPA cluster"

}

variable "proxy_config_name" {
  type = string

  description = "Name of the proxy config to use for the environment."

}

variable "workload_analytics" {
  type = bool

  description = "Flag to specify if workload analytics should be enabled for the CDP environment"

}


# variable "datalake_scale" {
#   type = string

#   description = "The scale of the datalake. Valid values are LIGHT_DUTY, MEDIUM_DUTY_HA."

#   validation {
#     condition     = contains(["LIGHT_DUTY", "MEDIUM_DUTY_HA"], var.datalake_scale)
#     error_message = "Valid values for var: datalake_scale are (LIGHT_DUTY, MEDIUM_DUTY_HA)."
#   }

# }

# variable "datalake_version" {
#   type = string

#   description = "The Datalake Runtime version. Valid values are semantic versions, e.g. 7.2.16"

#   validation {
#     condition     = length(regexall("\\d+\\.\\d+.\\d+", var.datalake_version)) > 0
#     error_message = "Valid values for var: datalake_version must match semantic versioning conventions."
#   }

# }

# ------- Cloud Service Provider Settings -------

variable "project_id" {
  type = string

  description = "GCP project to deploy CDP environment."
  
    validation {
    condition     = var.project_id != null
    error_message = "Valid values for var: project_id must be a valid GCP project."
  }

}

variable "region" {
  type        = string
  description = "Region which Cloud resources will be created"

    validation {
    condition     = var.region != null
    error_message = "Valid values for var: region must be a valid GCP region."
  }

}


variable "network_name" {
  type        = string
  description = "GCP Network VPC name."

      validation {
    condition     = var.network_name != null
    error_message = "Valid values for var: network_name must be a valid GCP VPC name."
  }


}

variable "cdp_subnet_names" {
  type        = list(any)
  description = "List of GCP Subnet Names for CDP Resources."

  validation {
    condition     = var.cdp_subnet_names != null
    error_message = "Valid values for var: cdp_subnet_names must be a list of existing GCP subnet names."
  }

}

variable "firewall_default_id" {
  type = string
  description = "Default Firewall for CDP environment"

  validation {
    condition = var.firewall_default_id != null
    error_message = "Valid values for var: firewall_default_id must be ID of an existing GCP Firewall rule."
  }
  
}

variable "firewall_knox_id" {
  type = string
  description = "Knox Firewall for CDP environment"

  validation {
    condition = var.firewall_knox_id != null
    error_message = "Valid values for var: firewall_knox_id must be ID of an existing GCP Firewall rule."
  }
  
}

variable "endpoint_access_scheme" {
  type = string

  description = "The scheme for the workload endpoint gateway. PUBLIC creates an external endpoint that can be accessed over the Internet. PRIVATE which restricts the traffic to be internal to the VPC. Relevant in Private Networks."

  validation {
    condition     = contains(["PUBLIC", "PRIVATE"], var.endpoint_access_scheme)
    error_message = "Valid values for var: endpoint_access_scheme are (PUBLIC, PRIVATE)."
  }
}

variable "encryption_key" {
  type = string

  description = "Key Resource ID of the customer managed encryption key to encrypt GCP resources."

}

variable "data_storage_location" {
  type        = string
  description = "Data storage location."
}

variable "log_storage_location" {
  type        = string
  description = "Log storage location."
}

variable "backup_storage_location" {
  type        = string
  description = "Backup storage location."
}

variable "public_key_text" {
  type = string

  description = "SSH Public key string for the nodes of the CDP environment"
}

variable "use_public_ips" {
  type = bool

  description = "Use public ips for the CDP resources created within the GCP network"

}

variable "xaccount_service_account_private_key" {
  type = string

  description = "Base64 encoded private key of the GCP Cross Account Service Account Key."

  validation {
    condition     = var.xaccount_service_account_private_key != null
    error_message = "Valid values for var: xaccount_service_account_private_key must be a valid Base64 encoded Private Key for the GCP Cross Account Service Account Key."
  }

}

variable "log_service_account_email" {
  type = string

  description = "Email id of the service account for Log Storage"

    validation {
    condition     = var.log_service_account_email != null
    error_message = "Valid values for var: log_service_account_email must be a valid Email id for the GCP Log Service Account."
  }

}