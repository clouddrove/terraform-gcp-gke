provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}

module "Service-account" {
  source  = "clouddrove/Service-account/gcp"
  version = "1.0.0"


  name        = "test"
  environment = var.environment
  label_order = var.label_order

  service_account_enabled = true
}

module "gke" {
  source = "../"

  name                               = "test-gke"
  module_enabled                     = true
  google_container_cluster_enabled   = true
  location                           = "europe-west3"
  remove_default_node_pool           = true
  initial_node_count                 = 1
  google_container_node_pool_enabled = true
  node_count                         = 1
  cluster_name                       = "test-gke"
  project_id                         = var.gcp_project_id
  region                             = var.gcp_region
  service_account                    = "prashantyadav@clouddrove.iam.gserviceaccount.com"

}