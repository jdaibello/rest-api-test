locals {
  cluster_node_role_names = [
    "control-plane",
    "worker",
    "worker"
  ]
}

resource "kind_cluster" "backend_cluster" {
  name            = "rest-api-test-local-cluster"
  node_image      = "kindest/node:v1.27.1"
  kubeconfig_path = "${path.module}/../k8s/.kube/config.yaml"
  wait_for_ready  = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    dynamic "node" {
      for_each = local.cluster_node_role_names

      content {
        role = node.value

        # dynamic "extra_port_mappings" {
        #   for_each = node.value == "control-plane" ? [1] : []

        #   content {
        #     container_port = 80
        #     host_port      = 80
        #   }
        # }
      }
    }
  }
}

output "kubeconfig_path" {
  value = kind_cluster.backend_cluster.kubeconfig_path
}
