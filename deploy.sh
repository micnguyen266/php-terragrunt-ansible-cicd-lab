#!/bin/bash

# Usage message if no argument provided
if [ -z "$1" ]; then
  echo "Usage: $0 {deploy|destroy}"
  exit 1
fi

ACTION=$1

# Change to the Terragrunt directory where your ec2 configuration lives
cd infrastructure/live/dev/ec2 || { echo "Failed to change directory"; exit 1; }

if [ "$ACTION" == "deploy" ]; then
  echo "Deploying EC2 instance with Terragrunt..."
  terragrunt apply -auto-approve

  # Extract the public IP from Terragrunt output.
  PUBLIC_IP=$(terragrunt output -raw instance_public_ip)
  if [ -z "$PUBLIC_IP" ]; then
    echo "Failed to retrieve public IP from Terragrunt output."
    exit 1
  fi

  echo "Public IP: $PUBLIC_IP"

  # Change directory to where your playbook is located (update this path as needed)
  cd ../../../../ansible || { echo "Failed to change directory to ansible/"; exit 1; }

  # Create inventory.ini for Ansible (make sure to add inventory.ini to .gitignore)
  cat <<EOF > inventory.ini
[web]
$PUBLIC_IP ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/lab.pem ansible_python_interpreter=/usr/bin/python3.8
EOF

  echo "Inventory file created with public IP: $PUBLIC_IP"
  echo "Running Ansible playbook..."

#  ansible-playbook -i ../ansible/inventory.ini lamp.yml
  ansible-playbook -i ../ansible/inventory.ini webserver.yml

elif [ "$ACTION" == "destroy" ]; then
  echo "Destroying EC2 instance with Terragrunt..."
  terragrunt destroy -auto-approve

else
  echo "Invalid option. Use 'deploy' or 'destroy'."
  exit 1
fi