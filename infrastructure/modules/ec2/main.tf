resource "aws_instance" "lamp" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids

  tags = {
    Name = var.instance_name
  }
}