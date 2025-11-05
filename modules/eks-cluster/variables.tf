

// Environment

variable "aws_region" {
  description = "AWS region"
  type        = string
}

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

variable "alb_controller_role_arn" {
  description = "IRSA role ARN for the AWS Load Balancer Controller"
  type        = string
}

variable "app_name" {
  description = "Kubernetes app/deployment name"
  type        = string
  default     = "nginx-webserver"
}

variable "svc_name" {
  description = "Kubernetes Service name"
  type        = string
  default     = "nginx-service"
}

variable "ingress_name" {
  description = "Kubernetes Ingress name"
  type        = string
  default     = null # module will coalesce to "${var.environment}-nginx-ing" if you used that logic
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



