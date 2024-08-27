variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = []
  description = "Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] ."
}

variable "name" {
  type        = string
  default     = ""
  description = "Name of the resource. Provided by the client when the resource is created. "
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Whether to create the resources. Set to `false` to prevent the module from creating any resources."
}

variable "google_container_cluster_enabled" {
  type        = bool
  default     = true
  description = "Flag to control the cluster_enabled creation."
}

variable "location" {
  type        = string
  default     = ""
  description = "The location (region or zone) in which the cluster master will be created, as well as the default node location."
}

variable "remove_default_node_pool" {
  type        = bool
  default     = true
  description = "deletes the default node pool upon cluster creation."
}

variable "initial_node_count" {
  type        = number
  default     = 1
  description = "The number of nodes to create in this cluster's default node pool."
}

variable "cluster_network_policy" {
  description = "Network policy configuration for the GKE cluster"
  type = map(object({
    enabled  = bool
    provider = string
  }))
  default = {
    policy1 = {
      enabled  = true
      provider = "CALICO"
    }
  }
}

variable "managed_node_pool" {
  type        = any
  default     = {}
  description = "Map of self-managed node pools definitions to create"
}

variable "self_node_pools" {
  type        = any
  default     = {}
  description = "Map of self-managed node pools definitions to create"
}

variable "service_account" {
  type        = string
  default     = ""
  description = "The Google Cloud Platform Service Account to be used by the node VMs created by GKE Autopilot or NAP."
}

######################### Autoscaling ###########################
variable "min_node_count" {
  type    = number
  default = 2
}

variable "max_node_count" {
  type    = number
  default = 7
}

variable "location_policy" {
  type    = string
  default = "BALANCED"
}

######################### management ###########################
variable "auto_repair" {
  type    = bool
  default = true
}

variable "auto_upgrade" {
  type    = bool
  default = true
}

variable "deletion_protection" {
  type        = bool
  default     = true
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

######################### node_config ###########################
variable "image_type" {
  type    = string
  default = ""
}

variable "machine_type" {
  type    = string
  default = ""
}

variable "disk_size_gb" {
  type    = number
  default = 50
}

variable "disk_type" {
  type    = string
  default = ""
}

variable "preemptible" {
  type    = bool
  default = false
}

######################### timeouts ###########################
variable "cluster_create_timeouts" {
  type    = string
  default = "30m"
}

variable "cluster_update_timeouts" {
  type    = string
  default = "30m"
}

variable "cluster_delete_timeouts" {
  type    = string
  default = "30m"
}

variable "kubectl_config_path" {
  description = "Path to the kubectl config file. Defaults to $HOME/.kube/config"
  type        = string
  default     = ""
}

variable "cluster_name" {
  type    = string
  default = ""
}

variable "project_id" {
  type        = string
  default     = ""
  description = "Google Cloud project ID"
}

variable "region" {
  type        = string
  default     = ""
  description = "Google Cloud region"
}
variable "network" {
  type        = string
  default     = ""
  description = "A reference (self link) to the VPC network to host the cluster in"

}

variable "subnetwork" {
  type        = string
  default     = ""
  description = "A reference (self link) to the subnetwork to host the cluster in"

}
variable "gke_version" {
  type        = string
  default     = ""
  description = "The minimum version of the master. "
}

variable "cluster_ipv4_cidr" {
  type        = string
  default     = ""
  description = "The IP address range of the Kubernetes pods in this cluster in CIDR notation (e.g. 10.96.0.0/14)."
}

variable "cluster_autoscaling" {
  type        = bool
  default     = false
  description = "Node Auto-Provisioning with Cluster Autoscaler to automatically adjust the size of the cluster"
}

########## Addons Config ##########

variable "http_load_balancing" {
  type        = bool
  default     = true
  description = "Set it false you if want to enable http load balancing"
}

variable "horizontal_pod_autoscaling" {
  type        = bool
  default     = true
  description = "Set it false you if want to enable horizontal pod autoscaling"
}

variable "network_policy" {
  type        = bool
  default     = true
  description = "Set it false you if want to enable network policy"
}

variable "pod_security_policy" {
  type        = bool
  default     = true
  description = "PodSecurityPolicy controller for this cluster. If enabled, pods must be valid under a PodSecurityPolicy to be created."
}

variable "spot" {
  description = "Enable or disable spot (preemptible) instances for the node pool"
  type        = bool
  default     = false
}

variable "enable_preemptible" {
  description = "Enable or disable preemptible nodes"
  type        = bool
  default     = false
}

variable "enable_private_endpoint" {
  description = "Enable or disable the private endpoint for the GKE cluster"
  type        = bool
  default     = false
}

variable "enable_private_nodes" {
  description = "Enable or disable private nodes for the GKE cluster"
  type        = bool
  default     = true
}

variable "master_ipv4_cidr_block" {
  description = "The IP range in CIDR notation for the master network in a private GKE cluster. This block is used to assign IP addresses to the master nodes and control access to the master API server. This is only required when 'enable_private_nodes' is set to true."
  type        = string
  default     = ""
}

variable "labels" {
  type = map(string)
  default = {
    application = "my-app"
  }
}

variable "cluster_ipv4_cidr_block" {
  description = "The IP range for the cluster pod IPs"
  type        = string
  default     = "/14"  
}

variable "services_ipv4_cidr_block" {
  description = "The IP range for the services IPs"
  type        = string
  default     = "/20"  
}

variable "workload_metadata_mode" {
  description = "The mode for workload metadata configuration."
  type        = string
  default     = "GKE_METADATA"
}

variable "master_authorized_networks" {
  description = "A list of CIDR blocks that are allowed to access the master node."
  type = list(object({
    cidr_block   = string
    display_name = string
  }))
  default = [
    {
      cidr_block   = "10.0.0.0/28"
      display_name = "default-network"
    }
  ]
}

variable "enable_master_authorized_networks" {
  description = "Whether to enable master authorized networks for the GKE cluster."
  type        = bool
  default     = true
}