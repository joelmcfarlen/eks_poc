

// Environment

variable "environment" {
  type        = string
  description = "Environment name (configured in root file)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Common tags (configured in root file)"
}


// Networking

variable "vpc_id" {
  type        = string
  description = "VPC for the cluster (configured in root file)"
}

variable "private_subnets" {
  type        = list(string)
  description = "Private subnet IDs (configured in root file)"
}

variable "public_subnets" {
  type        = list(string)
  description = "Public subnet IDs (configured in root file)"
}


// EKS

variable "kubernetes_version" {
  type        = string
  default     = "1.34"
  description = "Kubernetes version (Use for updating EKS version)"
}

variable "cluster_role_arn" {
  type        = string
  description = "IAM role ARN for the EKS control plane"
}

variable "node_role_arn" {
  description = "IAM role ARN for the EKS managed node group"
  type        = string
}

variable "node_group_desired_size" {
  description = "Desired node count for the EKS managed node group (configured in root tfvars file)"
  type        = number
}

variable "node_group_min_size" {
  description = "Minimum node count for the EKS managed node group (configured in root tfvars file)"
  type        = number
}

variable "node_group_max_size" {
  description = "Maximum node count for the EKS managed node group (configured in root tfvars file)"
  type        = number
}

variable "node_group_ami_type" {
  description = "AMI type for the EKS managed node group (configured in root tfvars file)"
  type        = string
}

variable "node_group_instance_type" {
  description = "Instance type for the EKS managed node group (configured in root tfvars file)"
  type        = list(string)
}



