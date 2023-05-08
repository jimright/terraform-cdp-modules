#!/usr/bin/env bash

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

#################################################
# Bash script to extract the account id and
# external id of the CDP Public Cloud control plane.
#
# Accepts the Cloud Provider type as a dictionary input
# and uses the command
#    'cdp environments get-credential-prerequisites'
# to then determine the ids. These are then returned as a
# JSON object for use in the TF pre-reqs module.
#############################

# Step 1 - Parse the inputs and get upper and lower case version of infra_type
eval "$(jq -r '@sh "region=\(.region)"')"

# Step 2 - Run the aws cli command
export AWS_OUTPUT=$(aws ec2 describe-vpcs --region ${region} | jq '.Vpcs | length')

# Step 3 - Parse required outputs into variables
created_vpcs_per_region=$(echo $AWS_OUTPUT)

# Step 4 - Output in JSON format
jq -n --arg created_vpcs_per_region $created_vpcs_per_region \
      '{"created_vpcs_per_region":$created_vpcs_per_region}'
