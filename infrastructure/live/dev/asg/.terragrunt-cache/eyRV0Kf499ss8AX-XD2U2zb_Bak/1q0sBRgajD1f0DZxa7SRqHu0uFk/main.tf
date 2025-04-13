# Launch Template with user_data (base64 encoded user_data file)
resource "aws_launch_template" "example" {
  name_prefix   = "lab-asg-"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = var.vpc_security_group_ids

  # For example, user_data can be a file that installs your application.
  # Adjust the path to your user_data script.
  user_data = base64encode(file("user_data.sh.tpl"))
}

# Auto Scaling Group
resource "aws_autoscaling_group" "example" {
  name                      = "lab-asg"
  desired_capacity          = 2
  min_size                  = 2
  max_size                  = 2
  vpc_zone_identifier       = var.subnets

  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.instance_name
    propagate_at_launch = true
  }
}

# Application Load Balancer
resource "aws_lb" "example" {
  name               = "my-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = var.lb_security_groups
}

# Target Group for the ALB
resource "aws_lb_target_group" "example" {
  name        = "my-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    interval            = 30
    path                = "/"
    port                = 80
    protocol            = "HTTP"
  }
}

# Attach the ASG to the Target Group
resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.example.name
  lb_target_group_arn    = aws_lb_target_group.example.arn
}

# Listener on ALB
resource "aws_lb_listener" "example" {
  load_balancer_arn = aws_lb.example.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}