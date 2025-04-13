output "instance_launch_template_id" {
  value = aws_launch_template.example.id
}

output "asg_name" {
  value = aws_autoscaling_group.example.name
}

output "alb_dns_name" {
  value = aws_lb.example.dns_name
}

output "instance_public_ips" {
  description = "Public IPs of the ASG instances"
  value       = [for inst in data.aws_instance.each_instance : inst.public_ip]
}