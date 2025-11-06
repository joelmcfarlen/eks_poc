

resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.environment}-eks-cluster"
  role_arn = var.cluster_role_arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids = concat(var.public_subnets, var.private_subnets)

    endpoint_public_access  = true
    endpoint_private_access = false
  }

  enabled_cluster_log_types = ["api", "audit"]

  tags = merge(
    var.tags,
    { Name = "${var.environment}-eks-cluster" }
  )

  # Prevent Terraform from attempting an EKS update
  lifecycle {
    ignore_changes = [
      compute_config,
      storage_config,
    ]
  }
}
