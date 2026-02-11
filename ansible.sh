#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# 1. SSH Configuration
# ------------------------------------------------------------------------------
# Configure global SSH settings and the specific project private key

nano ~/.ssh/config           # Edit SSH host aliases (bastion, web1, web2)
nano ~/.ssh/project.pem      # Paste the AWS private key content
chmod 400 ~/.ssh/project.pem # Set restricted permissions required by SSH

# 2. Connection Validation
# ------------------------------------------------------------------------------
# Verify that SSH connectivity is working for all target nodes
ssh bastion "echo 'Bastion reachable'"
ssh web1    "echo 'Web1 reachable'"
ssh web2    "echo 'Web2 reachable'"

# 3. Playbook Execution
# ------------------------------------------------------------------------------
# Change directory to ensure Ansible finds local config files
cd ~/aws-ansible-project

# Execute the playbook using the defined inventory
ansible-playbook -i inventory.ini deploy-nginx.yml

