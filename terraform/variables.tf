variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "image_name" {
  description = "Docker image repository (without tag)"
  type        = string
  default     = "davidbp11/hello-world-server"
}

variable "image_tag" {
  description = "Immutable Docker image tag (commit SHA)"
  type        = string
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
  description = "NodePort for the service"
  type        = number
  default     = 30081
}

variable "namespace" {
  description = "Namespace for deployment"
  type        = string
  default     = "origoss"
}
