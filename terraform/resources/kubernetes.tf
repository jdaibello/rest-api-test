locals {
  # Namespaces for non-prod and prod clusters
  non_prod_cluster_namespaces = [
    "sandbox",
    "dev",
    "qa",
    "uat"
  ]
  prod_cluster_namespaces = [
    "prod"
  ]

  # Read the service.yaml file content
  service_yaml_content = file("${path.module}/../k8s/base/service.yaml")
  has_separators       = can(regex("---", local.service_yaml_content))
  yaml_documents       = local.has_separators ? split("---", local.service_yaml_content) : [local.service_yaml_content]
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
    name      = "regcred"
    namespace = "rest-api-test-${each.key}-ns"
  }

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "https://index.docker.io/v1/" = {
          username = var.dockerhub_username,
          password = var.dockerhub_password,
          email    = var.dockerhub_email,
          auth     = base64encode("${var.dockerhub_username}:${var.dockerhub_password}")
        }
      }
    })
  }

  depends_on = [kubernetes_namespace.local_cluster_namespace]

  type = "kubernetes.io/dockerconfigjson"
}

resource "kubernetes_secret" "regcred_secret_prod" {
  for_each = { for ns in local.prod_cluster_namespaces : ns => ns }

  metadata {
    name      = "regcred"
    namespace = "rest-api-test-${each.key}-ns"
  }

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "https://index.docker.io/v1/" = {
          username = var.dockerhub_username,
          password = var.dockerhub_password,
          email    = var.dockerhub_email,
          auth     = base64encode("${var.dockerhub_username}:${var.dockerhub_password}")
        }
      }
    })
  }

  depends_on = [kubernetes_namespace.local_cluster_namespace]

  type = "kubernetes.io/dockerconfigjson"
}

resource "kubernetes_manifest" "base_deployment" {
  manifest = yamldecode(file("${path.module}/../k8s/base/deployment.yaml"))

  depends_on = [kubernetes_namespace.local_cluster_namespace, kubernetes_secret.regcred_secret_non_prod, kubernetes_secret.regcred_secret_prod]
}

resource "kubernetes_manifest" "base_service" {
  count    = length(local.yaml_documents)
  manifest = yamldecode(element(local.yaml_documents, count.index))

  depends_on = [kubernetes_manifest.base_deployment]
}

resource "kubernetes_manifest" "base_statefulset" {
  manifest = yamldecode(file("${path.module}/../k8s/base/statefulset.yaml"))

  depends_on = [kubernetes_manifest.base_configmap, kubernetes_manifest.base_deployment]
}

resource "kubernetes_manifest" "base_configmap" {
  manifest = yamldecode(file("${path.module}/../k8s/base/configmap.yaml"))

  depends_on = [kubernetes_manifest.base_service]
}
