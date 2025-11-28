variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "image_name" {
  description = "Docker image for the HTTP server"
  type        = string
  default     = "csoszi/hello-world-server:latest"
}

variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "hello-world-server"
}

variable "replicas" {
  description = "Number of pod replicas"
  type        = number
  default     = 3
}

variable "service_node_port" {
  description = "NodePort value for the Kubernetes service"
  type        = number
  default     = 30081
}

variable "namespace" {
  default = "origoss"
  type = string
}
