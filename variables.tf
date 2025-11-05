

// ROOT VARIABLES


// Environment

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}


// Networking

variable "vpc" {
  description = "VPC ID"
  type        = string
}

variable "subnet_pv_1" {
  description = "Private subnet 1 ID"
  type        = string
}

variable "subnet_pv_2" {
  description = "Private subnet 2 ID"
  type        = string
}

variable "subnet_pv_3" {
  description = "Private subnet 3 ID"
  type        = string
}

variable "subnet_pub_1" {
  description = "Public subnet 1 ID"
  type        = string
}

variable "subnet_pub_2" {
  description = "Public subnet 2 ID"
  type        = string
}

variable "subnet_pub_3" {
  description = "Public subnet 3 ID"
  type        = string
}


// EKS

variable "node_group_ami_type" {
  description = "AMI type for the EKS managed node group"
  type        = string
}

variable "node_group_instance_type" {
  description = "Instance type for the EKS managed node group"
  type        = list(string)
}

variable "node_group_desired_size" {
  description = "Desired node count for the EKS managed node group"
  type        = number
}

variable "node_group_min_size" {
  description = "Minimum node count for the EKS managed node group"
  type        = number
}

variable "node_group_max_size" {
  description = "Maximum node count for the EKS managed node group"
  type        = number
}
