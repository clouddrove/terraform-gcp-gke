output "name" {
  value = join("", google_container_cluster.cluster.*.name)
}

output "id" {
  value = join("", google_container_cluster.cluster.*.id)
}

output "endpoint" {
  value = join("", google_container_cluster.cluster.*.endpoint)
}

output "cluster_ca_certificate" {
  value = join("", google_container_cluster.cluster.*.id)
}