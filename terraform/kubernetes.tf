locals {
  non_prod_cluster_namespaces = [
    "sandbox",
    "dev",
    "qa",
    "uat"
  ]
}

resource "kubernetes_namespace" "local_cluster_namespace" {
  for_each = toset(local.non_prod_cluster_namespaces)

  metadata {
    name = "rest-api-test-${each.key}-ns"
  }
}