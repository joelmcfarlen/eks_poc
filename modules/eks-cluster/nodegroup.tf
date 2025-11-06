

locals {
  cluster_name   = "${var.environment}-eks-cluster"
  nodegroup_name = "${var.environment}-eks-ng"
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = local.nodegroup_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnets
  version         = var.kubernetes_version

  scaling_config {
    desired_size = var.node_group_desired_size
    max_size     = var.node_group_max_size
    min_size     = var.node_group_min_size
  }

  capacity_type  = "ON_DEMAND"
  ami_type       = var.node_group_ami_type
  instance_types = var.node_group_instance_type
  disk_size      = 20

  labels = {
    env = var.environment
  }

  tags = merge(
    var.tags,
    { Name = local.nodegroup_name }
  )
}
