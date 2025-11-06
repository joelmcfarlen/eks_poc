

data "aws_eks_cluster" "eks_cluster_for_irsa" {
  name = aws_eks_cluster.eks_cluster.name
}


resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  url = data.aws_eks_cluster.eks_cluster_for_irsa.identity[0].oidc[0].issuer
  client_id_list = ["sts.amazonaws.com"]

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-eks-oidc-provider"
      env  = var.environment
    }
  )
}


data "aws_iam_policy_document" "alb_controller_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.eks_oidc_provider.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks_oidc_provider.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }
  }
}

resource "aws_iam_role" "alb_controller_role" {
  name               = "${var.environment}-alb-controller-role"
  assume_role_policy = data.aws_iam_policy_document.alb_controller_assume_role.json

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-alb-controller-role"
      env  = var.environment
    }
  )
}


resource "aws_iam_policy" "alb_controller_policy" {
  name   = "${var.environment}-alb-controller-policy"
  policy = file("${path.module}/aws-lb-controller-policy.json")

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-alb-controller-policy"
      env  = var.environment
    }
  )
}

resource "aws_iam_role_policy_attachment" "alb_controller_attach" {
  role       = aws_iam_role.alb_controller_role.name
  policy_arn = aws_iam_policy.alb_controller_policy.arn
}

