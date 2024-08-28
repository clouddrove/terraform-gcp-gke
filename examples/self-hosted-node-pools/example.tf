provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}

module "vpc" {
  source  = "clouddrove/vpc/gcp"
  version = "1.0.0"

  name = "test-vpc"
  environment                    = var.environment
  label_order                    = var.label_order
  google_compute_network_enabled = true
  enable_ula_internal_ipv6       = false
}

module "subnet" {
  source = "clouddrove/subnet/gcp"

  name = "dev-test"
  environment = var.environment
  label_order = var.label_order
  gcp_region = "us-central1"
  version    = "1.0.1"

  google_compute_subnetwork_enabled  = true
  google_compute_firewall_enabled    = true
  google_compute_router_nat_enabled  = true
  module_enabled                     = true
  ipv6_access_type                   = "EXTERNAL"
  network                            = module.vpc.vpc_id
  project_id                         = var.gcp_project_id
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

  log_config = {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
    metadata_fields      = ["SRC_IP", "DST_IP"]
    filter_expr          = "true"
  }

}


module "gke" {
  source = "../../"

  name = "gke"
  environment = var.environment
  label_order = var.label_order

  network    = module.vpc.vpc_id
  subnetwork = module.subnet.id
  project_id = var.gcp_project_id
  region     = "us-central1"

  cluster_name                    = "test-gke"
  location                        = "us-central1"
  gke_version                     = "1.30.2-gke.1587003"
  remove_default_node_pool        = true
  service_account                 = "example@example.gserviceaccount.com"
  deletion_protection             = false
  cluster_autoscaling             = false
  http_load_balancing             = false
  horizontal_pod_autoscaling      = false
  network_policy                  = false
  pod_security_policy             = true
  spot                            = true
  enable_private_endpoint         = false
  enable_private_nodes            = false
  master_ipv4_cidr_block          = "10.13.0.0/28"
  cluster_ipv4_cidr_block         = "/14"
  services_ipv4_cidr_block        = "/20"
  enable_ip_allocation_policy     = false
  enable_workload_metadata_config = false
  workload_metadata_mode          = "GKE_METADATA"
  machine_type                    = "g1-small"
  initial_node_count              = 1
  node_location                   = "us-central1-a"
  disk_size_gb                    = 30
  cluster_network_policy = {
    policy1 = {
      enabled  = false
      provider = "CALICO"
    }
  }
  enable_master_authorized_networks = false
  master_authorized_networks = [
    {
      cidr_block   = "192.168.1.0/24"
      display_name = "Office Network"
    },
  ]
  self_node_pools = {
    critical = {
      name               = "critical-2"
      initial_node_count = 1
      image_type         = "COS_CONTAINERD"
      machine_type       = "g1-small"
      disk_size_gb       = 10 
      disk_type          = "pd-standard"
      preemptible        = true
      node_location      = "us-central1-a"
    },
    general = {
      name               = "general"
      initial_node_count = 1
      image_type         = "COS_CONTAINERD"
      machine_type       = "g1-small"
      disk_size_gb       = 20          
      disk_type          = "pd-standard"
      preemptible        = true
    }
  }

  enable_resource_labels = false

  resource_labels = {
    "env" = "production"
  }
}