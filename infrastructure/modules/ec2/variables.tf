variable "user_data_template" {
  description = "Path to the user data template file"
  type        = string
  default     = "user_data.sh.tpl"
}

variable "ami" {
  description = "AMI to use for the instance"
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
  description = "List of security group IDs to assign"
  type        = list(string)
}

variable "instance_name" {
  description = "Tag name for the instance"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}