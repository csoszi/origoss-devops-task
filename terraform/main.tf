resource "kubernetes_manifest" "namespace" {
  manifest = yamldecode(templatefile("namespace.tftpl", {
    namespace = var.namespace
  }))
}

resource "kubernetes_manifest" "deployment" {
  manifest = yamldecode(templatefile("k8s_deployment.yaml", {
    namespace  = var.namespace
    image_name = var.image_name
    image_tag  = var.image_tag
    app_name   = var.app_name
    replicas   = var.replicas
  }))
}

resource "kubernetes_manifest" "service" {
  manifest = yamldecode(templatefile("k8s_service.yaml", {
    namespace         = var.namespace
    app_name          = var.app_name
    service_node_port = var.service_node_port
  }))
}
