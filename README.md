# terragrunt-ansible-cicd-lab

1. When running the deploy.sh script. Terragrunt will run to deploy EC2 instance and then it will generate an inventory.ini file for Ansible to run.
   2. Run `deploy.sh deploy` to deploy EC2
   3. Run `deploy.sh destroy` to destroy EC2
2. Ansible will deploy a simple Tic-Tac-Toe app by copying it to the EC2 Apache Server.
3. A Github actions workflow called "deploy_app.yml" will create a temp VM and run the ansible playbook to deploy the latest app code after receiving a change on the main branch. Please note to update the EC2_PUBLIC_IP variable in Github secrets since the EC2 Public IP address may change.