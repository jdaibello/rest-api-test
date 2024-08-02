variable "aws_region" {
  description = "AWS region to use."
  type        = string
  default     = "us-east-2"
}

variable "kubeconfig_path" {
  description = "Path to the kubeconfig file."
  type        = string
}

variable "dockerhub_email" {
  description = "Email address to login on Docker Hub Registry."
  type        = string
}

variable "dockerhub_username" {
  description = "Docker Hub Registry username."
  type        = string
}

variable "dockerhub_password" {
  description = "Password to login on Docker Hub Registry. Prefer to use a Personal Access Token."
  type        = string
  sensitive   = true
}
