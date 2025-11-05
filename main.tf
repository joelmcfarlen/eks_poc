

// ROOT MAIN


//  IAM Module 

module "iam" {
  source      = "./modules/iam"
  environment = var.environment
  tags        = local.common_tags
}


//  EKS Cluster Module

module "eks_cluster" {
  source                   = "./modules/eks-cluster"
  environment              = var.environment
  vpc_id                   = var.vpc
  private_subnets          = [var.subnet_pv_1, var.subnet_pv_2, var.subnet_pv_3]
  public_subnets           = [var.subnet_pub_1, var.subnet_pub_2, var.subnet_pub_3]
  cluster_role_arn         = module.iam.eks_cluster_role_arn
  node_role_arn            = module.iam.eks_node_role_arn
  node_group_ami_type      = var.node_group_ami_type
  node_group_instance_type = var.node_group_instance_type
  node_group_desired_size  = var.node_group_desired_size
  node_group_min_size      = var.node_group_min_size
  node_group_max_size      = var.node_group_max_size
  tags                     = local.common_tags
}