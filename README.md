# terragrunt-ansible-cicd-lab

1. When running the deploy.sh script. Terragrunt will run to deploy EC2 instance and then it will generate an inventory.ini file for Ansible to run.
   2. Run `deploy.sh deploy` to deploy EC2
   3. Run `deploy.sh destroy` to destroy EC2
2. Ansible will deploy a simple PHP app.
3. Create CI/CD pipeline using Github actions to update PHP app after a change has been merged to master.