provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}

module "vpc" {
  source  = "clouddrove/vpc/gcp"
  version = "1.0.0"

  name                           = "test-vpc"
  environment                    = var.environment
  label_order                    = var.label_order
  google_compute_network_enabled = true
  enable_ula_internal_ipv6       = false
}

module "subnet" {
  source = "clouddrove/subnet/gcp"

  name        = "dev-test"
  environment = var.environment
  label_order = var.label_order
  gcp_region  = "us-central1"

  google_compute_subnetwork_enabled  = true
  google_compute_firewall_enabled    = true
  google_compute_router_nat_enabled  = true
  module_enabled                     = true
  ipv6_access_type                   = "EXTERNAL"
  network                            = module.vpc.vpc_id
  project_id                         = "clouddrove"
  private_ip_google_access           = true
  allow                              = [{ "protocol" : "tcp", "ports" : ["1-65535"] }]
  source_ranges                      = ["10.10.0.0/16"]
  asn                                = 64514
  nat_ip_allocate_option             = "MANUAL_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  filter                             = "ERRORS_ONLY"
  dest_range                         = "0.0.0.0/0"
  next_hop_gateway                   = "default-internet-gateway"
  priority                           = 1000
  secondary_ip_ranges = [
    {
      "range_name" : "services",
      "ip_cidr_range" : "10.1.0.0/16"
    },

    {
      "range_name" : "pods",
      "ip_cidr_range" : "10.3.0.0/16"
    }
  ]
}


module "gke" {
  source = "../../"

  name        = "gke"
  environment = var.environment
  label_order = var.label_order

  network                    = module.vpc.vpc_id
  subnetwork                 = module.subnet.id
  project_id                 = var.gcp_project_id
  region                     = var.gcp_region
  cluster_name               = "test-gke"
  location                   = "us-central1"
  gke_version                = "1.29.1-gke.1589017"
  module_enabled             = true
  remove_default_node_pool   = true
  service_account            = ""
  deletion_protection        = false
  cluster_autoscaling        = false
  http_load_balancing        = false
  horizontal_pod_autoscaling = false
  network_policy = false
  master_authorized_networks = [
    {
      cidr_block   = "10.0.0.7/32"
      display_name = "net1"
    }
  ]
  self_node_pools = [
    {
      name               = "critical"
      initial_node_count = 1
      machine_type       = "g1-small"
      disk_size_gb       = "10"
      disk_type          = "pd-standard"
      preemptible        = true
    },
    {
      name               = "general"
      initial_node_count = 1
      machine_type       = "g1-small"
      disk_size_gb       = "10"
      disk_type          = "pd-standard"
      preemptible        = true
    }
  ]
}