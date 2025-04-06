# terragrunt-ansible-cicd-lab

1. When running the deploy.sh script. Terragrunt will run to deploy EC2 instance and then it will generate an inventory.ini file for Ansible to run.
   2. Run `deploy.sh deploy` to deploy EC2
   3. Run `deploy.sh destroy` to destroy EC2
2. Ansible will deploy a simple Tic-Tac-Toe app by git cloning from another repo.
3. Not yet done. Trying to leverage Github actions to automatically help run the Ansible playbook to update the latest code and/or update the DNS on Cloudflare when the Public IP of EC2 changes.