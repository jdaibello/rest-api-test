output "kubeconfig" {
  value = kind_cluster.backend_cluster.kubeconfig
}

output "endpoint" {
  value = kind_cluster.backend_cluster.endpoint
}

output "client_certificate" {
  value = kind_cluster.backend_cluster.client_certificate
}

output "client_key" {
  value = kind_cluster.backend_cluster.client_key
}

output "cluster_ca_certificate" {
  value = kind_cluster.backend_cluster.cluster_ca_certificate
}