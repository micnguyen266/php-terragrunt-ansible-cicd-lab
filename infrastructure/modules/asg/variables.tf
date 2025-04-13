variable "ami" {
  description = "AMI to use for the instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Security group IDs for the instances"
  type        = list(string)
}

variable "instance_name" {
  description = "Name tag for instances"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "subnets" {
  description = "Subnets for the Auto Scaling Group"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for the target group"
  type        = string
}

variable "lb_security_groups" {
  description = "Security group IDs for the load balancer"
  type        = list(string)
}