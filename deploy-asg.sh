#!/bin/bash

# Usage: ./deploy.sh {deploy|destroy}
if [ -z "$1" ]; then
  echo "Usage: $0 {deploy|destroy}"
  exit 1
fi

ACTION=$1

# Change directory to the Terragrunt ASG configuration
cd infrastructure/live/dev/asg || { echo "Failed to change to the Terragrunt directory"; exit 1; }

if [ "$ACTION" == "deploy" ]; then
  echo "Deploying Auto Scaling Group via Terragrunt..."
  terragrunt apply -auto-approve

  # Wait for the ASG to finish launching instances
  echo "Waiting 60 seconds for instances to start..."
  sleep 60

  # Retrieve the public IP addresses from the Terragrunt output
  # Make sure your Terraform module outputs 'instance_public_ips' as a JSON array.
  INSTANCE_IPS=$(terragrunt output -json instance_public_ips | jq -r '.[]')

  if [ -z "$INSTANCE_IPS" ]; then
    echo "No instance IPs found. Exiting."
    exit 1
  fi

  echo "Found instance IPs: $INSTANCE_IPS"

  # Change directory to where your Ansible playbook resides
  cd ../../../../ansible || { echo "Failed to change directory to ansible"; exit 1; }

  # Create a dynamic Ansible inventory file
  INVENTORY_FILE="inventory.ini"
  echo "[web]" > "$INVENTORY_FILE"
  for ip in $INSTANCE_IPS; do
    echo "$ip ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/lab.pem ansible_python_interpreter=/usr/bin/python3.8 ansible_ssh_extra_args='-o IdentitiesOnly=yes -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'" >> "$INVENTORY_FILE"
  done

  echo "Inventory file created:"
  cat "$INVENTORY_FILE"

  # Sleep for 60 seconds before running Ansible playbook. Python 3.8 is being installed by user-data script.
#  echo "Waiting 60 seconds for the instances to be ready..."
#  sleep 60

  # Run the Ansible playbook to deploy your application code
  ansible-playbook -i ../ansible/inventory.ini webserver.yml

elif [ "$ACTION" == "destroy" ]; then
  echo "Destroying Auto Scaling Group via Terragrunt..."
  terragrunt destroy -auto-approve

else
  echo "Invalid action. Use 'deploy' or 'destroy'."
  exit 1
fi