// ROOT MAIN

//  IAM Module 

module "iam" {
  source      = "./modules/iam"
  environment = var.environment
  tags        = local.common_tags
}


//  EKS Cluster Module

