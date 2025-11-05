

resource "kubernetes_deployment_v1" "nginx_webserver" {
  metadata {
    name      = var.app_name
    namespace = "default"
    labels    = {
      app = var.app_name
      env = var.environment
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
          env = var.environment
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:stable-alpine"

          port {
            container_port = 80
          }

          readiness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 3
            period_seconds        = 10
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "nginx_service" {
  metadata {
    name      = var.svc_name
    namespace = "default"
    labels = {
      app = var.app_name
      env = var.environment
    }
  }

  spec {
    selector = {
      app = var.app_name
    }

    port {
      name        = "http"
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}
