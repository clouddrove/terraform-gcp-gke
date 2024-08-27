module "labels" {
  source  = "clouddrove/labels/gcp"
  version = "1.0.0"

  name        = var.name
  environment = var.environment
  label_order = var.label_order
}

resource "google_container_cluster" "primary" {
  count    = var.google_container_cluster_enabled ? 1 : 0
  provider = google-beta
  project  = var.project_id

  name                     = module.labels.id
  location                 = var.location
  network                  = var.network
  subnetwork               = var.subnetwork
  remove_default_node_pool = var.remove_default_node_pool
  min_master_version       = var.gke_version
  deletion_protection      = var.deletion_protection
  cluster_ipv4_cidr        = var.cluster_ipv4_cidr
  initial_node_count       = var.managed_node_pool == {} ? var.initial_node_count : 0

  dynamic "master_authorized_networks_config" {
    for_each = var.enable_master_authorized_networks ? [1] : []

    content {
      dynamic "cidr_blocks" {
        for_each = var.master_authorized_networks

        content {
          cidr_block   = cidr_blocks.value.cidr_block
          display_name = cidr_blocks.value.display_name
        }
      }
    }
  }


  cluster_autoscaling {
    enabled = var.cluster_autoscaling

  }
  pod_security_policy_config {
    enabled = var.pod_security_policy
  }

  addons_config {
    http_load_balancing {
      disabled = !var.http_load_balancing
    }

    horizontal_pod_autoscaling {
      disabled = !var.horizontal_pod_autoscaling
    }

    network_policy_config {
      disabled = !var.network_policy
    }
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = var.cluster_ipv4_cidr_block
    services_ipv4_cidr_block = var.services_ipv4_cidr_block
    
  }

  dynamic "node_pool" {
    for_each = { for k, v in var.managed_node_pool : k => v if var.enabled }
    content {
      name               = node_pool.value.name
      initial_node_count = node_pool.value.initial_node_count
      node_config {
        machine_type = node_pool.value.machine_type
        disk_size_gb = node_pool.value.disk_size_gb
        disk_type    = node_pool.value.disk_type
        preemptible  = var.enable_preemptible
        spot         = var.spot

        labels = var.labels

        workload_metadata_config {
          mode = var.workload_metadata_mode
        }
      }
    }
  }

  private_cluster_config {
    enable_private_endpoint = var.enable_private_endpoint
    enable_private_nodes    = var.enable_private_nodes
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  dynamic "network_policy" {
    for_each = var.cluster_network_policy

    content {
      enabled  = network_policy.value.enabled
      provider = network_policy.value.provider
    }
  }
}

resource "google_container_node_pool" "node_pool" {
  for_each = { for k, v in var.self_node_pools : k => v if var.enabled }
  provider = google-beta

  name       = each.value.name
  project    = var.project_id
  location   = var.location
  cluster    = join("", google_container_cluster.primary[*].id)
  node_count = var.initial_node_count

  autoscaling {
    min_node_count  = var.min_node_count
    max_node_count  = var.max_node_count
    location_policy = var.location_policy
  }

  management {
    auto_repair  = var.auto_repair
    auto_upgrade = var.auto_upgrade
  }

  node_config {
    image_type      = var.image_type
    machine_type    = var.machine_type
    service_account = var.service_account
    disk_size_gb    = var.disk_size_gb
    disk_type       = var.disk_type
    preemptible     = var.preemptible


    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  lifecycle {
    ignore_changes        = [initial_node_count]
    create_before_destroy = false
  }

  timeouts {
    create = var.cluster_create_timeouts
    update = var.cluster_update_timeouts
    delete = var.cluster_delete_timeouts
  }

}

resource "null_resource" "configure_kubectl" {
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${var.cluster_name} --region ${var.region} --project ${var.project_id}"

    environment = {
      KUBECONFIG = var.kubectl_config_path != "" ? var.kubectl_config_path : ""
    }
  }
  depends_on = [google_container_node_pool.node_pool]
}
