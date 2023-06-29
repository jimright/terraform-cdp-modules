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

# Deployment and creation of CDP resources using Ansible Playbook called by TF local-exec

# ------- Create Configuration file for CDP Deployment via Ansible -------
resource "local_file" "cdp_deployment_template" {

  content = templatefile("${path.module}/templates/cdp_config.yml.tpl", {
    # CDP environment & DL settings
    plat__env_name                  = var.environment_name
    plat__datalake_name             = var.datalake_name
    plat__datalake_scale            = var.datalake_scale
    plat__datalake_version          = var.datalake_version
    plat__xacccount_credential_name = var.cdp_xacccount_credential_name
    plat__cdp_iam_admin_group_name  = var.cdp_admin_group_name
    plat__cdp_iam_user_group_name   = var.cdp_user_group_name
    plat__tunnel                    = var.enable_ccm_tunnel
    plat__endpoint_access_scheme    = var.endpoint_access_scheme
    plat__enable_raz                = var.enable_raz
    plat__env_multiaz               = var.multiaz
    plat__env_freeipa_instances     = var.freeipa_instances
    plat__workload_analytics        = var.workload_analytics
    plat__tags                      = jsonencode(var.tags)

    # CDP settings
    plat__cdp_profile              = var.cdp_profile
    plat__cdp_control_plane_region = var.cdp_control_plane_region

    # CSP settings
    plat__infra_type = "aws"
    plat__region     = var.region

    plat__aws_vpc_id             = var.vpc_id
    plat__aws_public_subnet_ids  = jsonencode(var.public_subnet_ids)
    plat__aws_private_subnet_ids = jsonencode(var.private_subnet_ids)
    plat__aws_subnets_for_cdp    = jsonencode(var.subnets_for_cdp)

    plat__aws_storage_location = var.data_storage_location
    plat__aws_log_location     = var.log_storage_location
    plat__aws_backup_location  = var.backup_storage_location

    plat__public_key_id                 = var.keypair_name
    plat__aws_security_group_default_id = var.security_group_default_id
    plat__aws_security_group_knox_id    = var.security_group_knox_id

    plat__aws_datalake_admin_role_arn = var.datalake_admin_role_arn
    plat__aws_ranger_audit_role_arn   = var.ranger_audit_role_arn
    plat__aws_xaccount_role_arn       = var.xaccount_role_arn

    plat__aws_log_instance_profile_arn      = var.log_instance_profile_arn
    plat__aws_idbroker_instance_profile_arn = var.idbroker_instance_profile_arn
    }
  )
  filename = "cdp_config.yml"
}

# ------- CDP Credential -------
resource "cdp_environments_aws_credential" "cdp_cred" {
  credential_name = var.cdp_xacccount_credential_name
  role_arn        = var.xaccount_role_arn
  description     = "AWS Cross Account Credential for AWS env ${var.environment_name}"
}

# ------- CDP Environment -------
resource "cdp_environments_aws_environment" "cdp_env" {
  environment_name = var.environment_name
  credential_name  = cdp_environments_aws_credential.cdp_cred.credential_name
  region           = var.region

  security_access = {
    default_security_group_id  = var.security_group_default_id
    security_group_id_for_knox = var.security_group_knox_id
  }

  log_storage = {
    storage_location_base        = var.log_storage_location
    backup_storage_location_base = var.backup_storage_location
    instance_profile             = var.log_instance_profile_arn
  }

  authentication = {
    public_key_id = var.keypair_name
  }

  vpc_id                             = var.vpc_id
  subnet_ids                         = var.subnets_for_cdp
  endpoint_access_gateway_scheme     = var.endpoint_access_scheme
  endpoint_access_gateway_subnet_ids = var.public_subnet_ids

  freeipa = {
    instance_count_by_group = var.freeipa_instances
    multi_az                = var.multiaz
  }

  workload_analytics = var.workload_analytics
  enable_tunnel      = var.enable_ccm_tunnel
  # tags               = var.tags

}

# ------- CDP Admin Group -------
# Create group
resource "cdp_iam_group" "cdp_admin_group" {
  group_name                    = var.cdp_admin_group_name
  sync_membership_on_user_login = false
}

# TODO: Assign roles and resource roles to the group

# TODO: Assign users to the group

# ------- CDP User Group -------
# Create group
resource "cdp_iam_group" "cdp_user_group" {
  group_name                    = var.cdp_user_group_name
  sync_membership_on_user_login = false
}

# TODO: Assign roles and resource roles to the group

# TODO: Assign users to the group

# ------- IdBroker Mappings -------
resource "cdp_environments_id_broker_mappings" "cdp_idbroker" {
  # TODO: Replace these with outputs from cdp_environments_aws_credential.cdp_cred
  environment_name = var.environment_name
  environment_crn  = "crn:cdp:environments:us-west-1:558bc1d2-8867-4357-8524-311d51259233:environment:da9258a4-de90-4013-aca2-6e292a6bc155"

  ranger_audit_role                   = var.ranger_audit_role_arn
  data_access_role                    = var.datalake_admin_role_arn
  ranger_cloud_access_authorizer_role = var.enable_raz ? var.datalake_admin_role_arn : ""
  set_empty_mappings = true

  # TODO: Works 
  # mappings = [{
  #     accessor_crn = cdp_iam_group.cdp_admin_group.crn
  #     role         = var.datalake_admin_role_arn
  #   },
  #   {
  #     accessor_crn = cdp_iam_group.cdp_user_group.crn
  #     role         = var.datalake_admin_role_arn
  # }
  # ]
}

# ------- CDP Datalake -------
resource "cdp_datalake_aws_datalake" "cdp_datalake" {
  datalake_name = var.datalake_name
  # TODO: Replace this with resource output from cdp_environments_aws_credential.cdp_cred
  # NOTE: If not linked to resource then is this parallel deployment
  environment_name        = var.environment_name
  instance_profile        = var.idbroker_instance_profile_arn
  storage_bucket_location = var.data_storage_location

  runtime           = var.datalake_version
  scale             = var.datalake_scale
  enable_ranger_raz = var.enable_raz
  multi_az          = var.multiaz

  # tags = var.tags
}
