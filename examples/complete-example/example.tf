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
  version     = "1.0.1"


  google_compute_subnetwork_enabled  = true
  google_compute_firewall_enabled    = true
  google_compute_router_nat_enabled  = true
  module_enabled                     = true
  ipv6_access_type                   = "EXTERNAL"
  network                            = module.vpc.vpc_id
  project_id                         = "project_id"
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

module "gke-dev-jetic-cluster" {
  source                     = "../../"
  project_id                 = var.gcp_project_id
  name                       = "cluster-1"
  region                     = "us-central1"
  zones                      = ["us-central1-c"]
  network                    = "test-vpc-dev"
  subnetwork                 = "dev-test"
  ip_range_pods              = "pods"
  workload_config_audit_mode = "BASIC"
  security_posture_mode      = "BASIC"
  kubernetes_version         = "1.30.2-gke.1587003"
  regional                   = true

  logging_service                   = "logging.googleapis.com/kubernetes"
  monitoring_service                = "monitoring.googleapis.com/kubernetes"
  enable_private_nodes              = true
  release_channel                   = "STABLE"
  horizontal_pod_autoscaling        = true
  http_load_balancing               = false
  filestore_csi_driver              = true
  istio                             = false
  network_policy                    = true
  ip_range_services                 = "services"
  create_service_account            = false
  cluster_resource_labels           = { env = "test" }
  service_account                   = "example@example.gserviceaccount.com"
  remove_default_node_pool          = true
  disable_legacy_metadata_endpoints = true
  deletion_protection               = false


  node_pools = [
    {
      name                         = "critical"
      master_version               = "1.30.2-gke.1587003"
      machine_type                 = "g1-small"
      node_locations               = "us-central1-c"
      min_count                    = 1
      max_count                    = 1
      local_ssd_count              = 0
      spot                         = true
      disk_size_gb                 = 10
      disk_type                    = "pd-standard"
      image_type                   = "cos_containerd"
      enable_gcfs                  = false
      enable_gvnic                 = false
      logging_variant              = "DEFAULT"
      auto_repair                  = true
      auto_upgrade                 = true
      create_service_account       = false
      service_account              = "example@example.gserviceaccount.com"
      preemptible                  = false
      initial_node_count           = 1
      enable_node_pool_autoscaling = false
      enable_private_nodes         = true

    },
    {
      name                         = "application"
      master_version               = "1.30.2-gke.1587003"
      machine_type                 = "g1-small"
      node_locations               = "us-central1-c"
      min_count                    = 1
      max_count                    = 2
      local_ssd_count              = 0
      spot                         = true
      disk_size_gb                 = 10
      disk_type                    = "pd-standard"
      image_type                   = "cos_containerd"
      enable_gcfs                  = false
      enable_gvnic                 = false
      logging_variant              = "DEFAULT"
      auto_repair                  = true
      auto_upgrade                 = true
      create_service_account       = false
      service_account              = "example@example.gserviceaccount.com"
      preemptible                  = false
      initial_node_count           = 1
      enable_node_pool_autoscaling = true
      enable_private_nodes         = true
    },
  ]

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }

}
