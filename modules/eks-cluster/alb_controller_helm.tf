

resource "kubernetes_service_account" "aws_load_balancer_controller_sa" {
  metadata {
    name      = "aws-load-balancer-controller"  
    namespace = "kube-system"
    labels    = { env = var.environment }
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.alb_controller_role.arn
    }
  }
  automount_service_account_token = true
}

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"


  values = [yamlencode({
    clusterName = aws_eks_cluster.eks_cluster.name
    region      = var.aws_region
    vpcId       = var.vpc_id 
    serviceAccount = {
      create = false
      name   = "aws-load-balancer-controller"
    }
  })]

  timeout       = 600
  wait          = true
  force_update  = true         
  recreate_pods = true         
  
  depends_on = [
    aws_iam_openid_connect_provider.eks_oidc_provider,
    aws_iam_role_policy_attachment.alb_controller_attach,
    kubernetes_service_account.aws_load_balancer_controller_sa
  ]
}
