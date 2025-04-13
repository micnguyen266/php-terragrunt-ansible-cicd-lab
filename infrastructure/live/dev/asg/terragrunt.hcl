terraform {
  source = "../../../modules/asg"
}

inputs = {
  ami                  = "ami-0a9a48ce4458e384e"  # Replace with the Amazon Linux 2 AMI ID for your region
  instance_type        = "t2.micro"
  key_name             = "lab"
  vpc_security_group_ids = ["sg-0271a2a5dfeba64a2"]  # Update with your SG IDs for the instances
  instance_name        = "asg-dev-instance"
  subnets              = ["subnet-039e9d9f504a7f0f7", "subnet-0cba74126426cf0e8"]  # List of subnets in your VPC
  vpc_id               = "vpc-0d833e4c0798a3f2c"            # Your VPC ID
  lb_security_groups   = ["sg-0271a2a5dfeba64a2"]           # SG IDs for the load balancer
}