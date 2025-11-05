

resource "kubernetes_ingress_v1" "nginx_ingress" {
  metadata {
    name      = coalesce(var.ingress_name, "${var.environment}-nginx-ing")
    namespace = "default"
    labels    = { env = var.environment }
    annotations = {
      "kubernetes.io/ingress.class"               = "alb"
      "alb.ingress.kubernetes.io/scheme"          = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"     = "ip"
      "alb.ingress.kubernetes.io/listen-ports"    = "[{\"HTTP\":80}]"

      "alb.ingress.kubernetes.io/group.name"          = "${var.environment}-alb-group"
      "alb.ingress.kubernetes.io/load-balancer-name"  = "${var.environment}-nginx-alb"
      "alb.ingress.kubernetes.io/tags"                = join(",", [
        for k, v in merge(
          var.tags,
          {
            Name = "${var.environment}-nginx-alb"
            env  = var.environment
          }
        ) : "${k}=${v}"
      ])
    }
  }

  spec {
    rule {
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service_v1.nginx_service.metadata[0].name
              port { number = 80 }
            }
          }
        }
      }
    }
  }

  depends_on = [helm_release.aws_load_balancer_controller]
}
