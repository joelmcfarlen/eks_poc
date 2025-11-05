

// ROOT MAIN


//  IAM Module 

module "iam" {
  source      = "./modules/iam"
  environment = var.environment
  tags        = local.common_tags
}


//  EKS Cluster Module

module "eks_cluster" {
  source           = "./modules/eks-cluster"
  environment      = var.environment
  cluster_role_arn = module.iam.eks_cluster_role_arn
  vpc_id           = var.vpc
  private_subnets  = [var.subnet_pv_1, var.subnet_pv_2, var.subnet_pv_3]
  public_subnets   = [var.subnet_pub_1, var.subnet_pub_2, var.subnet_pub_3]
  tags             = local.common_tags
}