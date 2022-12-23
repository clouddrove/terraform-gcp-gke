########################## provider #########################################
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}


########################## provider-kubernetes ###############################

provider "kubernetes" {
  host                   = data.template_file.gke_host_endpoint.rendered
  token                  = data.template_file.access_token.rendered
  cluster_ca_certificate = data.template_file.cluster_ca_certificate.rendered
}

########################## kms ##############################################

module "kms" {
  source  = "clouddrove/kms/gcp"
  version = "1.0.0"

  environment = var.environment
  label_order = var.label_order
  project_id       = var.gcp_project_id
  name          = "keyringss"
  location         = var.location
  keys             = ["dev-gke"]
  prevent_destroy  = false
  service_accounts = ["serviceAccount:service-943862527560@container-engine-robot.iam.gserviceaccount.com"]
  role             = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
}

data "google_client_config" "client" {}
data "google_client_openid_userinfo" "terraform_user" {}

########################## gke_cluster ##############################################

module "gke_cluster" {
  source = "../"

  name        = "stepler-gke-cluster"
  environment = var.environment
  label_order = var.label_order

  project  = var.gcp_project_id
  location = var.location


  network    = var.vpc_id
  subnetwork = var.subnet_id
  cluster_secondary_range_name = "services"
  services_secondary_range_name = "pods"
  master_ipv4_cidr_block = "10.10.0.0/28"

  disable_public_endpoint = "false"
  resource_labels = {
    environment = "development"
  }
  cluster                    = module.gke_cluster.name
  initial_node_count         = "1"
  secrets_encryption_kms_key = module.kms.key

  node_pools = {
    development-node-pool = {
      node_name = "development-node-pool"
      location = var.location
      initial_node_count = "1"
      min_node_count  = "1"
      max_node_count  = "4"
      location_policy = "BALANCED"
      auto_repair  = "true"
      auto_upgrade = "false"
      env_label = "dev"
      image_type      = "cos_containerd"
      machine_type    = "ni-standard-4"
      disk_size_gb    = "30"
      disk_type       = "pd-standard"
      preemptible     = true
      oauth_scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring"]
      max_surge       = 1
      max_unavailable = 0
    }

    stage-node-pool = {
      node_name = "stage-node-pool"
      location = var.location
      initial_node_count = "1"
      min_node_count  = "1"
      max_node_count  = "5"
      location_policy = "BALANCED"
      auto_repair  = "true"
      auto_upgrade = "false"
      env_label = "dev"
      image_type      = "cos_containerd"
      machine_type    = "ni-highcpu-4"
      disk_size_gb    = "50"
      disk_type       = "pd-standard"
      preemptible     = true
      oauth_scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring"]
      max_surge       = 1
      max_unavailable = 0
    }

    service-node-pool = {
      node_name = "service-node-pool"
      location = var.location
      initial_node_count = "1"
      min_node_count  = "1"
      max_node_count  = "3"
      location_policy = "BALANCED"
      auto_repair  = "true"
      auto_upgrade = "false"
      env_label = "dev"
      image_type      = "cos_containerd"
      machine_type    = "n1-standard-4"
      disk_size_gb    = "30"
      disk_type       = "pd-standard"
      preemptible     = true
      oauth_scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring"]
      max_surge       = 1
      max_unavailable = 0
    }

  }


  ###############################  timeouts ###################################

  cluster_create_timeouts = "30m"
  cluster_update_timeouts = "30m"
  cluster_delete_timeouts = "30m"
}


# ---------------------------------------------------------------------------------------------------------------------
# WORKAROUNDS
# ---------------------------------------------------------------------------------------------------------------------


data "template_file" "gke_host_endpoint" {
  template = module.gke_cluster.endpoint
}

data "template_file" "access_token" {
  template = data.google_client_config.client.access_token
}

data "template_file" "cluster_ca_certificate" {
  template = module.gke_cluster.cluster_ca_certificate
}
