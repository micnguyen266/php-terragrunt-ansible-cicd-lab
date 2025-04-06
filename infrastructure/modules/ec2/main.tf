resource "aws_instance" "lamp" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  user_data              = <<EOF
#!/bin/bash
yum update -y
amazon-linux-extras enable python3.8
yum clean metadata
yum install -y python3.8
alternatives --set python3 /usr/bin/python3.8
python3 --version
EOF
  # Other configurations...

  tags = {
    Name = var.instance_name
  }
}