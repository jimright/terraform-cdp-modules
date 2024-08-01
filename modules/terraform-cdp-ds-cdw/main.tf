# ------- Create Configuration file for CDP Deployment via Ansible -------
resource "local_file" "cdp_deployment_template" {

  content = templatefile("${path.module}/templates/cdp_config.yml.tpl", {
    # CDP environment & DL settings
    env_prefix                               = var.env_prefix
    infra_type                               = var.infra_type
    cdp_env                                  = var.cdp_environment_name
    azure_aks_managed_identity_id            = coalesce(var.azure_aks_managed_identity_name, "None")
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
