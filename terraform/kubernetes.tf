locals {
  non_prod_cluster_namespaces = [
    "sandbox",
    "dev",
    "qa",
    "uat"
  ]
  prod_cluster_namespaces = [
    "prod"
  ]
}

resource "kubernetes_namespace" "local_cluster_namespace" {
  for_each = setunion(toset(local.non_prod_cluster_namespaces), toset(local.prod_cluster_namespaces))

  metadata {
    name = "rest-api-test-${each.key}-ns"
  }
}

resource "kubernetes_secret" "regcred_secret_non_prod" {
  for_each = { for ns in local.non_prod_cluster_namespaces : ns => ns }

  metadata {
    name = "regcred"
    namespace = "rest-api-test-${each.key}-ns"
  }

  data = {
      ".dockerconfigjson" = jsonencode({
      auths = {
        "https://index.docker.io/v1/" = {
          username = var.dockerhub_username,
          password = var.dockerhub_password,
          email = var.dockerhub_email,
          auth = base64encode("${var.dockerhub_username}:${var.dockerhub_password}")
        }
      }
    })
  }

  type = "kubernetes.io/dockerconfigjson"
}

resource "kubernetes_secret" "regcred_secret_prod" {
  for_each = { for ns in local.prod_cluster_namespaces : ns => ns }

  metadata {
    name = "regcred"
    namespace = "rest-api-test-${each.key}-ns"
  }

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "https://index.docker.io/v1/" = {
          username = var.dockerhub_username,
          password = var.dockerhub_password,
          email = var.dockerhub_email,
          auth = base64encode("${var.dockerhub_username}:${var.dockerhub_password}")
        }
      }
    })
  }

  type = "kubernetes.io/dockerconfigjson"
}

resource "kubernetes_manifest" "base_deployment" {
  manifest = yamldecode(file("${path.cwd}/k8s/base/deployment.yaml"))
}

resource "kubernetes_manifest" "base_service" {
  manifest = yamldecode(file("${path.cwd}/k8s/base/service.yaml"))
}