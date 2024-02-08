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

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

}

provider "azuread" {
}

#*********** TESTING CUSTOM XACCOUNT ROLE **************
data "azurerm_subscription" "current" {}

# NOTE: suggestion from CDPAUTO-142. ??
resource "azurerm_role_definition" "custom_xaccount_role" {
  name        = "${var.env_prefix}-custom-xaccount-role"
  scope       = data.azurerm_subscription.current.id
  description = "Custom XAccount Role for ${var.env_prefix}"

  permissions {
    actions = [
      "Microsoft.Storage/locations/deleteVirtualNetworkOrSubnets/action",
      "Microsoft.Network/virtualNetworks/read",
      "Microsoft.Network/virtualNetworks/write",
      "Microsoft.Network/virtualNetworks/delete",
      "Microsoft.Network/virtualNetworks/subnets/read",
      "Microsoft.Network/virtualNetworks/subnets/write",
      "Microsoft.Network/virtualNetworks/subnets/delete",
      "Microsoft.Network/virtualNetworks/subnets/join/action",
      "Microsoft.Network/virtualNetworks/subnets/joinViaServiceEndpoint/action",
      "Microsoft.Network/networkInterfaces/read",
      "Microsoft.Network/networkInterfaces/write",
      "Microsoft.Network/networkInterfaces/delete",
      "Microsoft.Network/networkInterfaces/join/action",
      "Microsoft.Network/networkInterfaces/ipconfigurations/read",
      "Microsoft.Network/networkSecurityGroups/read",
      "Microsoft.Network/networkSecurityGroups/write",
      "Microsoft.Network/networkSecurityGroups/delete",
      "Microsoft.Network/networkSecurityGroups/join/action",
      "Microsoft.Network/publicIPAddresses/read",
      "Microsoft.Network/publicIPAddresses/write",
      "Microsoft.Network/publicIPAddresses/delete",
      "Microsoft.Network/publicIPAddresses/join/action",
      "Microsoft.Compute/availabilitySets/read",
      "Microsoft.Compute/availabilitySets/write",
      "Microsoft.Compute/availabilitySets/delete",
      "Microsoft.Compute/disks/read",
      "Microsoft.Compute/disks/write",
      "Microsoft.Compute/disks/delete",
      "Microsoft.Compute/images/read",
      "Microsoft.Compute/images/write",
      "Microsoft.Compute/images/delete",
      "Microsoft.Compute/virtualMachines/read",
      "Microsoft.Compute/virtualMachines/write",
      "Microsoft.Compute/virtualMachines/delete",
      "Microsoft.Compute/virtualMachines/start/action",
      "Microsoft.Compute/virtualMachines/restart/action",
      "Microsoft.Compute/virtualMachines/deallocate/action",
      "Microsoft.Compute/virtualMachines/vmSizes/read",
      "Microsoft.Authorization/roleAssignments/read",
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Resources/deployments/read",
      "Microsoft.Resources/deployments/write",
      "Microsoft.Resources/deployments/delete",
      "Microsoft.Resources/deployments/operations/read",
      "Microsoft.Resources/deployments/operationstatuses/read",
      "Microsoft.Resources/deployments/exportTemplate/action",
      "Microsoft.Resources/subscriptions/read",
      "Microsoft.ManagedIdentity/userAssignedIdentities/write",
      "Microsoft.ManagedIdentity/userAssignedIdentities/read",
      "Microsoft.ManagedIdentity/userAssignedIdentities/assign/action",
      "Microsoft.DBforPostgreSQL/servers/write",
      "Microsoft.DBforPostgreSQL/servers/delete",
      "Microsoft.DBforPostgreSQL/servers/virtualNetworkRules/write",
      # Fix after Error 1 - storage access
      "Microsoft.Storage/storageAccounts/read",
      "Microsoft.Storage/storageAccounts/listKeys/action",
      # Fix after Error 2 - Flexible Servers
      "Microsoft.DBforPostgreSQL/flexibleServers/write",
      "Microsoft.DBforPostgreSQL/flexibleServers/delete",
      "Microsoft.DBforPostgreSQL/flexibleServers/start/action",
      "Microsoft.DBforPostgreSQL/flexibleServers/read",
      "Microsoft.DBforPostgreSQL/flexibleServers/stop/action",
      # Fix after Error 3 - flexible server FW rule
      "Microsoft.DBforPostgreSQL/flexibleServers/firewallRules/write",
      # Fix after Error 4 - Network LB
      "Microsoft.Network/loadBalancers/write",
      # Fix after teardown error
      "Microsoft.Network/loadBalancers/delete",
      # Fix after Error 5 - NLB join
      "Microsoft.Network/loadBalancers/backendAddressPools/join/action",
      # Fix after Error for HA DH creation
      "Microsoft.Network/loadBalancers/read",
      # Fix for successful CML deployment
      "Microsoft.ContainerService/managedClusters/read"
    ]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.current.id, # /subscriptions/00000000-0000-0000-0000-000000000000
  ]
}
#**********************************************

#*********** TESTING CUSTOM IDBroker ROLE **************
# IDBroker Role1: Virtual Machine Contributor and Managed Identity Operator
resource "azurerm_role_definition" "custom_idbroker_role1" {
  name        = "${var.env_prefix}-custom-idbroker-role1"
  scope       = data.azurerm_subscription.current.id
  description = "Custom IDBroker Role for ${var.env_prefix}"

  permissions {
    actions = [
      "Microsoft.Authorization/*/read",
      "Microsoft.Compute/availabilitySets/*",
      "Microsoft.Compute/locations/*",
      "Microsoft.Compute/virtualMachines/*",
      "Microsoft.Compute/virtualMachineScaleSets/*",
      "Microsoft.Compute/cloudServices/* ",
      "Microsoft.Compute/disks/write",
      "Microsoft.Compute/disks/read",
      "Microsoft.Compute/disks/delete",
      "Microsoft.DevTestLab/schedules/*",
      "Microsoft.Insights/alertRules/*",
      "Microsoft.Network/applicationGateways/backendAddressPools/join/action",
      "Microsoft.Network/loadBalancers/backendAddressPools/join/action",
      "Microsoft.Network/loadBalancers/inboundNatPools/join/action",
      "Microsoft.Network/loadBalancers/inboundNatRules/join/action",
      "Microsoft.Network/loadBalancers/probes/join/action",
      "Microsoft.Network/loadBalancers/read",
      "Microsoft.Network/locations/*",
      "Microsoft.Network/networkInterfaces/*",
      "Microsoft.Network/networkSecurityGroups/join/action",
      "Microsoft.Network/networkSecurityGroups/read",
      "Microsoft.Network/publicIPAddresses/join/action",
      "Microsoft.Network/publicIPAddresses/read",
      "Microsoft.Network/virtualNetworks/read",
      "Microsoft.Network/virtualNetworks/subnets/join/action",
      "Microsoft.RecoveryServices/locations/*",
      "Microsoft.RecoveryServices/Vaults/backupFabrics/backupProtectionIntent/write",
      "Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/*/read",
      "Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/read",
      "Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/write",
      "Microsoft.RecoveryServices/Vaults/backupPolicies/read",
      "Microsoft.RecoveryServices/Vaults/backupPolicies/write",
      "Microsoft.RecoveryServices/Vaults/read",
      "Microsoft.RecoveryServices/Vaults/usages/read",
      "Microsoft.RecoveryServices/Vaults/write",
      "Microsoft.ResourceHealth/availabilityStatuses/read",
      "Microsoft.Resources/deployments/*",
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.SerialConsole/serialPorts/connect/action",
      "Microsoft.SqlVirtualMachine/* ",
      "Microsoft.Storage/storageAccounts/listKeys/action",
      "Microsoft.Storage/storageAccounts/read",
      "Microsoft.Support/*"
    ]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.current.id,
  ]
}

# IDBroker Role2: Storage blob data contributor
resource "azurerm_role_definition" "custom_idbroker_role2" {
  name        = "${var.env_prefix}-custom-idbroker-role2"
  scope       = data.azurerm_subscription.current.id
  description = "Custom IDBroker Role for ${var.env_prefix}"

  permissions {
    actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/delete",
      "Microsoft.Storage/storageAccounts/blobServices/containers/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/write",
      "Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey/action"
    ]
    not_actions = []
    data_actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/delete",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/move/action",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/add/action"
    ]
  }

  assignable_scopes = [
    data.azurerm_subscription.current.id,
  ]
}

#**********************************************

module "cdp_azure_prereqs" {
  source = "../../../terraform-cdp-azure-pre-reqs"

  #*** Testing Azure custom role ***
  # ...xaccount
  xaccount_role_assignments = [{
    role = azurerm_role_definition.custom_xaccount_role.name
  }]

  # ....idbroker
  idbroker_role_assignments = [
    {
    role = azurerm_role_definition.custom_idbroker_role1.name
    description = "Custom Virtual Machine Contributor and Managed Identity Operator"
    },
    {
    role = azurerm_role_definition.custom_idbroker_role2.name
    description = "Custom Storage Blob Data Contributor"
    }
    ]
  #*** END ***

  env_prefix   = var.env_prefix
  azure_region = var.azure_region

  deployment_template           = var.deployment_template
  ingress_extra_cidrs_and_ports = var.ingress_extra_cidrs_and_ports

  # Inputs for BYO-VNet
  create_vnet            = var.create_vnet
  cdp_resourcegroup_name = var.cdp_resourcegroup_name
  cdp_vnet_name          = var.cdp_vnet_name
  cdp_subnet_names       = var.cdp_subnet_names
  cdp_gw_subnet_names    = var.cdp_gw_subnet_names

}

module "cdp_deploy" {
  source = "../.."

  env_prefix          = var.env_prefix
  infra_type          = "azure"
  region              = var.azure_region
  public_key_text     = var.public_key_text
  deployment_template = var.deployment_template

  # From pre-reqs module output
  azure_subscription_id = module.cdp_azure_prereqs.azure_subscription_id
  azure_tenant_id       = module.cdp_azure_prereqs.azure_tenant_id

  azure_resource_group_name      = module.cdp_azure_prereqs.azure_resource_group_name
  azure_vnet_name                = module.cdp_azure_prereqs.azure_vnet_name
  azure_cdp_subnet_names         = module.cdp_azure_prereqs.azure_cdp_subnet_names
  azure_cdp_gateway_subnet_names = module.cdp_azure_prereqs.azure_cdp_gateway_subnet_names

  azure_security_group_default_uri = module.cdp_azure_prereqs.azure_security_group_default_uri
  azure_security_group_knox_uri    = module.cdp_azure_prereqs.azure_security_group_knox_uri

  data_storage_location   = module.cdp_azure_prereqs.azure_data_storage_location
  log_storage_location    = module.cdp_azure_prereqs.azure_log_storage_location
  backup_storage_location = module.cdp_azure_prereqs.azure_backup_storage_location

  azure_xaccount_app_uuid  = module.cdp_azure_prereqs.azure_xaccount_app_uuid
  azure_xaccount_app_pword = module.cdp_azure_prereqs.azure_xaccount_app_pword

  azure_idbroker_identity_id      = module.cdp_azure_prereqs.azure_idbroker_identity_id
  azure_datalakeadmin_identity_id = module.cdp_azure_prereqs.azure_datalakeadmin_identity_id
  azure_ranger_audit_identity_id  = module.cdp_azure_prereqs.azure_ranger_audit_identity_id
  azure_log_identity_id           = module.cdp_azure_prereqs.azure_log_identity_id
  azure_raz_identity_id           = module.cdp_azure_prereqs.azure_raz_identity_id

  depends_on = [
    module.cdp_azure_prereqs
  ]
}
