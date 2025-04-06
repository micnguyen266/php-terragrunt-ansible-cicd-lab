resource "aws_instance" "lamp" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids

    # Use the templatefile() function to read user_data.sh.tpl
  user_data = templatefile("${path.module}/${var.user_data_template}", {
    # Pass in variables if needed
    # e.g., my_var = var.my_value
  })

  tags = {
    Name = var.instance_name
  }
}