

output "cluster_name" {
  value       = aws_eks_cluster.eks_cluster.name
  description = "EKS cluster name"
}

output "cluster_arn" {
  value       = aws_eks_cluster.eks_cluster.arn
  description = "EKS cluster ARN"
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.eks_cluster.endpoint
  description = "EKS API server endpoint"
}

output "cluster_certificate_authority_data" {
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
  description = "Base64-encoded certificate data"
}

output "cluster_security_group_id" {
  value       = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
  description = "Cluster SG (created by EKS)"
}

output "oidc_issuer_url" {
  value       = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
  description = "OIDC issuer URL (use later for IRSA/ALB controller)"
}
