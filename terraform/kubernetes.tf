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