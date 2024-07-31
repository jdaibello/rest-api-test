locals {
  cluster_node_role_names = [
    "control-plane",
    "worker",
    "worker"
  ]
}

resource "kind_cluster" "backend_cluster" {
  name            = "rest-api-test"
  node_image      = "kindest/node:v1.27.1"
  kubeconfig_path = pathexpand("/tmp/kube/config")
  wait_for_ready  = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    dynamic "node" {
      for_each = local.cluster_node_role_names

      content {
        role = node.value
      }
    }
  }
}
