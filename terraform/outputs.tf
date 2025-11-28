/*
output "service_node_port" {
  description = "NodePort where application is exposed"
  value       = kubernetes_service.app_service.spec[0].port[0].node_port
}

output "deployment_name" {
  description = "Name of the deployment created"
  value       = kubernetes_deployment.app.metadata[0].name
}

output "service_name" {
  description = "Name of the service created"
  value       = kubernetes_service.app_service.metadata[0].name
}
*/