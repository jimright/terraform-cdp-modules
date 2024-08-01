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

resource "azurerm_role_assignment" "cdp_cdw_aks_cred_storage_assign" {

  count = (var.infra_type == "azure") ? 1 : 0

  scope                = data.azurerm_storage_account.data_storage_account.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azurerm_user_assigned_identity.cdp_cdw_aks_cred[0].principal_id

  description = "Storage Blob Data Owner assignment to CDP Data Storage Container"
}

# NOTE: Hit issues running this on localhost because ansible_python_interpreter lookup is performed (venv ignored)
# resource "ansible_playbook" "configure_ds" {
#   playbook = "${path.module}/playbook_setup_ds.yml"
#   name     = "localhost"

#   replayable              = true
#   ignore_playbook_failure = true

#   extra_vars = {
#     ansible_connection = "local"
#     # ansible_python_interpreter = "/mnt/jenright/data/Cloudera/virtualenvs/cloud_dl_backup_dev_py3.9_ansible2.12/bin/python"
#     env_prefix = var.env_prefix
#     infra_type = var.infra_type
#     cdp_env    = var.cdp_environment_name
#     azure_aks_credential_managed_identity_id = try(azurerm_user_assigned_identity.cdp_cdw_aks_cred[0].id, null)
#     cdp_admin_group = var.cdp_admin_group
#     cdp_user_group = var.cdp_user_group
#   }

#   depends_on = [ azurerm_user_assigned_identity.cdp_cdw_aks_cred ]
# }

# ------- Create Configuration file for CDP Deployment via Ansible -------
resource "local_file" "cdp_deployment_template" {

  content = templatefile("${path.module}/templates/cdp_config.yml.tpl", {
    # CDP environment & DL settings
    env_prefix                               = var.env_prefix
    infra_type                               = var.infra_type
    cdp_env                                  = var.cdp_environment_name
    azure_aks_credential_managed_identity_id = try(azurerm_user_assigned_identity.cdp_cdw_aks_cred[0].id, null)
    cdp_admin_group                          = var.cdp_admin_group
    cdp_user_group                           = var.cdp_user_group
    }
  )
  filename = "cdp_config.yml"
}

resource "null_resource" "cdp_deployment" {
  # Not required when using config file
  # triggers = {
  #   cdp_env = var.cdp_environment_name
  # }

  # Setup of CDW assets using playbook_setup_ds.yml Ansible Playbook
  provisioner "local-exec" {
    command = "ansible-playbook -vvv -e '@cdp_config.yml' ${path.module}/playbook_setup_ds.yml"
  }

  # Deletion of CDW assets using playbook_teardown_ds.yml Ansible Playbook
  provisioner "local-exec" {
    when    = destroy
    command = "ansible-playbook -vvv -e '@cdp_config.yml' ${path.module}/playbook_teardown_ds.yml"
  }

  # Not required when using config file
  # provisioner "local-exec" {
  #   when    = destroy
  #   command = "ansible-playbook ${path.module}/playbook_teardown_ds.yml -e \"cdp_env=${self.triggers.cdp_env}\""
  # }

  depends_on = [
    local_file.cdp_deployment_template
  ]
}
