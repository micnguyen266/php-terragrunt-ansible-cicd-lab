# php-terragrunt-ansible-cicd-lab

1. Run deploy_and_run.sh script. Terragrunt will run to deploy EC2 instance and then it will generate inventory.ini file for Ansible to run.
2. Ansible will deploy a simple PHP app.
3. Create CI/CD pipeline using Github actions to update PHP app after a change has been merged to master.