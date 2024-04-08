# Create Azure Managed Identity
resource "azurerm_user_assigned_identity" "cdp_cdw_aks_cred" {
  
  count = (var.infra_type == "azure") ? 1 : 0

  # location            = data.azurerm_resource_group.cdp_ds_rmgp.location
  location            = var.region
  name                = local.azure_aks_credential_managed_identity_name
  resource_group_name = var.azure_resource_group_name

  tags = merge(local.env_tags, { Name = local.azure_aks_credential_managed_identity_name })
}

# Assign the required roles to the AKS credential managed identity
resource "azurerm_role_assignment" "cdp_cdw_aks_cred_assign" {

  for_each = {
    for idx, role in var.cdw_aks_cred_role_assignments : idx => role
    if var.infra_type == "azure"
  }

  scope                = data.azurerm_subscription.current.id
  role_definition_name = each.value.role
  principal_id         = azurerm_user_assigned_identity.cdp_cdw_aks_cred[0].principal_id

  description = each.value.description
}


resource "ansible_playbook" "configure_ds" {
  playbook = "${path.module}/playbook_setup_ds.yml"
  name     = "localhost"

  replayable              = true
  ignore_playbook_failure = true

  extra_vars = {
    env_prefix = var.env_prefix
    infra_type = var.infra_type
    cdp_env    = var.cdp_environment_name
    azure_aks_credential_managed_identity_id = try(azurerm_user_assigned_identity.cdp_cdw_aks_cred[0].id, null)
  }
}