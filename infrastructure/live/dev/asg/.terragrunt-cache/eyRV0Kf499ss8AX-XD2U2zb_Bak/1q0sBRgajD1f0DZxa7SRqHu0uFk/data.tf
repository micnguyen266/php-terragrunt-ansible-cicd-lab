data "aws_instances" "asg_instances" {
  instance_tags = {
    "aws:autoscaling:groupName" = aws_autoscaling_group.example.name
  }
}

data "aws_instance" "each_instance" {
  count       = 2  # if you're expecting 2 instances
  instance_id = element(data.aws_instances.asg_instances.ids, count.index)
}