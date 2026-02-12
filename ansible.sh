#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# 1. SSH Configuration
# ------------------------------------------------------------------------------
# Configure global SSH settings and the specific project private key

nano ~/.ssh/config           # Edit SSH host aliases (bastion, web1, web2)
nano ~/.ssh/Day1-Key.pem      # Paste the AWS private key content
sudo chmod 400 ~/.ssh/Day1-Key.pem # Set restricted permissions required by SSH

# 2. Connection Validation
# ------------------------------------------------------------------------------
# Verify that SSH connectivity is working for all target nodes
ssh bastion "echo 'Bastion reachable'"
ssh web1    "echo 'Web1 reachable'"
ssh web2    "echo 'Web2 reachable'"

# 3. Playbook Execution
# ------------------------------------------------------------------------------
# Verify connectivity to private web servers through Bastion 
# if successful Execute the playbook using the defined inventory
echo "Starting Ansible Connectivity Check..."
ansible web -i inventory.ini -m ping

if [ $? -eq 0 ]; then
    echo "Connectivity Verified: Ready for Deployment."
    ansible-playbook -i inventory.ini deploy-nginx.yml
else
    echo "Error: Connectivity Failed. Check SSH Config and Security Groups."
    exit 1
fi


