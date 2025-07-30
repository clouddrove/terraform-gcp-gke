
locals {
  node_pools_labels = merge(
    { all = {} },
    { default-node-pool = {} },
    zipmap(
      [for node_pool in var.node_pools : node_pool["name"]],
      [for node_pool in var.node_pools : {}]
    ),
    zipmap(
      [for node_pool in var.windows_node_pools : node_pool["name"]],
      [for node_pool in var.windows_node_pools : {}]
    ),
    var.node_pools_labels
  )

  node_pools_resource_labels = merge(
    { all = {} },
    { default-node-pool = {} },
    zipmap(
      [for node_pool in var.node_pools : node_pool["name"]],
      [for node_pool in var.node_pools : {}]
    ),
    zipmap(
      [for node_pool in var.windows_node_pools : node_pool["name"]],
      [for node_pool in var.windows_node_pools : {}]
    ),
    var.node_pools_resource_labels
  )

  node_pools_metadata = merge(
    { all = {} },
    { default-node-pool = {} },
    zipmap(
      [for node_pool in var.node_pools : node_pool["name"]],
      [for node_pool in var.node_pools : {}]
    ),
    zipmap(
      [for node_pool in var.windows_node_pools : node_pool["name"]],
      [for node_pool in var.windows_node_pools : {}]
    ),
    var.node_pools_metadata
  )

  node_pools_taints = merge(
    { all = [] },
    { default-node-pool = [] },
    zipmap(
      [for node_pool in var.node_pools : node_pool["name"]],
      [for node_pool in var.node_pools : []]
    ),
    zipmap(
      [for node_pool in var.windows_node_pools : node_pool["name"]],
      [for node_pool in var.windows_node_pools : []]
    ),
    var.node_pools_taints
  )

  node_pools_tags = merge(
    { all = [] },
    { default-node-pool = [] },
    zipmap(
      [for node_pool in var.node_pools : node_pool["name"]],
      [for node_pool in var.node_pools : []]
    ),
    zipmap(
      [for node_pool in var.windows_node_pools : node_pool["name"]],
      [for node_pool in var.windows_node_pools : []]
    ),
    var.node_pools_tags
  )

  node_pools_oauth_scopes = merge(
    { all = ["https://www.googleapis.com/auth/cloud-platform"] },
    { default-node-pool = [] },
    zipmap(
      [for node_pool in var.node_pools : node_pool["name"]],
      [for node_pool in var.node_pools : []]
    ),
    zipmap(
      [for node_pool in var.windows_node_pools : node_pool["name"]],
      [for node_pool in var.windows_node_pools : []]
    ),
    var.node_pools_oauth_scopes
  )

  node_pools_linux_node_configs_sysctls = merge(
    { all = {} },
    { default-node-pool = {} },
    zipmap(
      [for node_pool in var.node_pools : node_pool["name"]],
      [for node_pool in var.node_pools : {}]
    ),
    var.node_pools_linux_node_configs_sysctls
  )

  # Cluster-level workload metadata config
  cluster_node_metadata_config = {
    default = {
      node_metadata = "GKE_METADATA"
    }
  }

  enable_monitoring_config = var.monitoring_enable_managed_prometheus || var.monitoring_enable_observability_metrics
}
