terraform {
  source = "../../../modules/ec2"
}

inputs = {
  ami                    = "ami-0a9a48ce4458e384e"  # Replace with a valid CentOS AMI ID for your region
  instance_type          = "t2.micro"
  key_name               = "lab"          # Replace with your EC2 key pair name
  vpc_security_group_ids = ["sg-0271a2a5dfeba64a2"] # Replace with your security group ID(s)
  instance_name          = "lamp-dev-instance"
}