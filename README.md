<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.9.0, < 6 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 5.9.0, < 6 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.10 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.9.0, < 6 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | >= 5.9.0, < 6 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2.10 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_container_cluster.primary](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_container_cluster) | resource |
| [google-beta_google_container_node_pool.pools](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_container_node_pool) | resource |
| [google-beta_google_container_node_pool.windows_pools](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_container_node_pool) | resource |
| [google-beta_google_project_service_identity.fleet_project](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_project_service_identity) | resource |
| [google_compute_firewall.intra_egress](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.master_webhooks](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.shadow_allow_inkubelet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.shadow_allow_master](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.shadow_allow_nodes](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.shadow_allow_pods](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.shadow_deny_exkubelet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.tpu_egress](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_project_iam_member.cluster_service_account-artifact-registry](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cluster_service_account-gcr](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cluster_service_account-nodeService_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.service_agent](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.cluster_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [kubernetes_config_map.ip-masq-agent](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_config_map_v1_data.kube-dns](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map_v1_data) | resource |
| [kubernetes_config_map_v1_data.kube-dns-upstream-nameservers-and-stub-domains](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map_v1_data) | resource |
| [kubernetes_config_map_v1_data.kube-dns-upstream-namservers](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map_v1_data) | resource |
| [random_shuffle.available_zones](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/shuffle) | resource |
| [random_string.cluster_service_account_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [google-beta_google_compute_zones.available](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/data-sources/google_compute_zones) | data source |
| [google_compute_subnetwork.gke_subnetwork](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_subnetwork) | data source |
| [google_container_engine_versions.region](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_engine_versions) | data source |
| [google_container_engine_versions.zone](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_engine_versions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_cluster_firewall_rules"></a> [add\_cluster\_firewall\_rules](#input\_add\_cluster\_firewall\_rules) | Create additional firewall rules | `bool` | `false` | no |
| <a name="input_add_master_webhook_firewall_rules"></a> [add\_master\_webhook\_firewall\_rules](#input\_add\_master\_webhook\_firewall\_rules) | Create master\_webhook firewall rules for ports defined in `firewall_inbound_ports` | `bool` | `false` | no |
| <a name="input_add_shadow_firewall_rules"></a> [add\_shadow\_firewall\_rules](#input\_add\_shadow\_firewall\_rules) | Create GKE shadow firewall (the same as default firewall rules with firewall logs enabled). | `bool` | `false` | no |
| <a name="input_additional_ip_range_pods"></a> [additional\_ip\_range\_pods](#input\_additional\_ip\_range\_pods) | List of _names_ of the additional secondary subnet ip ranges to use for pods | `list(string)` | `[]` | no |
| <a name="input_authenticator_security_group"></a> [authenticator\_security\_group](#input\_authenticator\_security\_group) | The name of the RBAC security group for use with Google security groups in Kubernetes RBAC. Group name must be in format gke-security-groups@yourdomain.com | `string` | `null` | no |
| <a name="input_cloudrun"></a> [cloudrun](#input\_cloudrun) | (Beta) Enable CloudRun addon | `bool` | `false` | no |
| <a name="input_cloudrun_load_balancer_type"></a> [cloudrun\_load\_balancer\_type](#input\_cloudrun\_load\_balancer\_type) | (Beta) Configure the Cloud Run load balancer type. External by default. Set to `LOAD_BALANCER_TYPE_INTERNAL` to configure as an internal load balancer. | `string` | `""` | no |
| <a name="input_cluster_autoscaling"></a> [cluster\_autoscaling](#input\_cluster\_autoscaling) | Cluster autoscaling configuration. See [more details](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters#clusterautoscaling) | <pre>object({<br>    enabled             = bool<br>    autoscaling_profile = string<br>    min_cpu_cores       = number<br>    max_cpu_cores       = number<br>    min_memory_gb       = number<br>    max_memory_gb       = number<br>    gpu_resources       = list(object({ resource_type = string, minimum = number, maximum = number }))<br>    auto_repair         = bool<br>    auto_upgrade        = bool<br>    disk_size           = optional(number)<br>    disk_type           = optional(string)<br>  })</pre> | <pre>{<br>  "auto_repair": true,<br>  "auto_upgrade": true,<br>  "autoscaling_profile": "BALANCED",<br>  "disk_size": 100,<br>  "disk_type": "pd-standard",<br>  "enabled": false,<br>  "gpu_resources": [],<br>  "max_cpu_cores": 0,<br>  "max_memory_gb": 0,<br>  "min_cpu_cores": 0,<br>  "min_memory_gb": 0<br>}</pre> | no |
| <a name="input_cluster_dns_domain"></a> [cluster\_dns\_domain](#input\_cluster\_dns\_domain) | The suffix used for all cluster service records. | `string` | `""` | no |
| <a name="input_cluster_dns_provider"></a> [cluster\_dns\_provider](#input\_cluster\_dns\_provider) | Which in-cluster DNS provider should be used. PROVIDER\_UNSPECIFIED (default) or PLATFORM\_DEFAULT or CLOUD\_DNS. | `string` | `"PROVIDER_UNSPECIFIED"` | no |
| <a name="input_cluster_dns_scope"></a> [cluster\_dns\_scope](#input\_cluster\_dns\_scope) | The scope of access to cluster DNS records. DNS\_SCOPE\_UNSPECIFIED (default) or CLUSTER\_SCOPE or VPC\_SCOPE. | `string` | `"DNS_SCOPE_UNSPECIFIED"` | no |
| <a name="input_cluster_ipv4_cidr"></a> [cluster\_ipv4\_cidr](#input\_cluster\_ipv4\_cidr) | The IP address range of the kubernetes pods in this cluster. Default is an automatically assigned CIDR. | `string` | `null` | no |
| <a name="input_cluster_resource_labels"></a> [cluster\_resource\_labels](#input\_cluster\_resource\_labels) | The GCE resource labels (a map of key/value pairs) to be applied to the cluster | `map(string)` | `{}` | no |
| <a name="input_cluster_telemetry_type"></a> [cluster\_telemetry\_type](#input\_cluster\_telemetry\_type) | Available options include ENABLED, DISABLED, and SYSTEM\_ONLY | `string` | `null` | no |
| <a name="input_config_connector"></a> [config\_connector](#input\_config\_connector) | Whether ConfigConnector is enabled for this cluster. | `bool` | `false` | no |
| <a name="input_configure_ip_masq"></a> [configure\_ip\_masq](#input\_configure\_ip\_masq) | Enables the installation of ip masquerading, which is usually no longer required when using aliasied IP addresses. IP masquerading uses a kubectl call, so when you have a private cluster, you will need access to the API server. | `bool` | `false` | no |
| <a name="input_create_service_account"></a> [create\_service\_account](#input\_create\_service\_account) | Defines if service account specified to run nodes should be created. | `bool` | `true` | no |
| <a name="input_database_encryption"></a> [database\_encryption](#input\_database\_encryption) | Application-layer Secrets Encryption settings. The object format is {state = string, key\_name = string}. Valid values of state are: "ENCRYPTED"; "DECRYPTED". key\_name is the name of a CloudKMS key. | `list(object({ state = string, key_name = string }))` | <pre>[<br>  {<br>    "key_name": "",<br>    "state": "DECRYPTED"<br>  }<br>]</pre> | no |
| <a name="input_datapath_provider"></a> [datapath\_provider](#input\_datapath\_provider) | The desired datapath provider for this cluster. By default, `DATAPATH_PROVIDER_UNSPECIFIED` enables the IPTables-based kube-proxy implementation. `ADVANCED_DATAPATH` enables Dataplane-V2 feature. | `string` | `"DATAPATH_PROVIDER_UNSPECIFIED"` | no |
| <a name="input_default_max_pods_per_node"></a> [default\_max\_pods\_per\_node](#input\_default\_max\_pods\_per\_node) | The maximum number of pods to schedule per node | `number` | `110` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Whether or not to allow Terraform to destroy the cluster. | `bool` | `true` | no |
| <a name="input_deploy_using_private_endpoint"></a> [deploy\_using\_private\_endpoint](#input\_deploy\_using\_private\_endpoint) | (Beta) A toggle for Terraform and kubectl to connect to the master's internal IP address during deployment. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the cluster | `string` | `""` | no |
| <a name="input_disable_default_snat"></a> [disable\_default\_snat](#input\_disable\_default\_snat) | Whether to disable the default SNAT to support the private use of public IP addresses | `bool` | `false` | no |
| <a name="input_disable_legacy_metadata_endpoints"></a> [disable\_legacy\_metadata\_endpoints](#input\_disable\_legacy\_metadata\_endpoints) | Disable the /0.1/ and /v1beta1/ metadata server endpoints on the node. Changing this value will cause all node pools to be recreated. | `bool` | `true` | no |
| <a name="input_dns_cache"></a> [dns\_cache](#input\_dns\_cache) | The status of the NodeLocal DNSCache addon. | `bool` | `false` | no |
| <a name="input_enable_binary_authorization"></a> [enable\_binary\_authorization](#input\_enable\_binary\_authorization) | Enable BinAuthZ Admission controller | `bool` | `false` | no |
| <a name="input_enable_confidential_nodes"></a> [enable\_confidential\_nodes](#input\_enable\_confidential\_nodes) | An optional flag to enable confidential node config. | `bool` | `false` | no |
| <a name="input_enable_cost_allocation"></a> [enable\_cost\_allocation](#input\_enable\_cost\_allocation) | Enables Cost Allocation Feature and the cluster name and namespace of your GKE workloads appear in the labels field of the billing export to BigQuery | `bool` | `false` | no |
| <a name="input_enable_fqdn_network_policy"></a> [enable\_fqdn\_network\_policy](#input\_enable\_fqdn\_network\_policy) | Enable FQDN Network Policies on the cluster | `bool` | `null` | no |
| <a name="input_enable_gcfs"></a> [enable\_gcfs](#input\_enable\_gcfs) | Enable image streaming on cluster level. | `bool` | `false` | no |
| <a name="input_enable_identity_service"></a> [enable\_identity\_service](#input\_enable\_identity\_service) | Enable the Identity Service component, which allows customers to use external identity providers with the K8S API. | `bool` | `false` | no |
| <a name="input_enable_intranode_visibility"></a> [enable\_intranode\_visibility](#input\_enable\_intranode\_visibility) | Whether Intra-node visibility is enabled for this cluster. This makes same node pod to pod traffic visible for VPC network | `bool` | `false` | no |
| <a name="input_enable_kubernetes_alpha"></a> [enable\_kubernetes\_alpha](#input\_enable\_kubernetes\_alpha) | Whether to enable Kubernetes Alpha features for this cluster. Note that when this option is enabled, the cluster cannot be upgraded and will be automatically deleted after 30 days. | `bool` | `false` | no |
| <a name="input_enable_l4_ilb_subsetting"></a> [enable\_l4\_ilb\_subsetting](#input\_enable\_l4\_ilb\_subsetting) | Enable L4 ILB Subsetting on the cluster | `bool` | `false` | no |
| <a name="input_enable_mesh_certificates"></a> [enable\_mesh\_certificates](#input\_enable\_mesh\_certificates) | Controls the issuance of workload mTLS certificates. When enabled the GKE Workload Identity Certificates controller and node agent will be deployed in the cluster. Requires Workload Identity. | `bool` | `false` | no |
| <a name="input_enable_network_egress_export"></a> [enable\_network\_egress\_export](#input\_enable\_network\_egress\_export) | Whether to enable network egress metering for this cluster. If enabled, a daemonset will be created in the cluster to meter network egress traffic. | `bool` | `false` | no |
| <a name="input_enable_pod_security_policy"></a> [enable\_pod\_security\_policy](#input\_enable\_pod\_security\_policy) | enabled - Enable the PodSecurityPolicy controller for this cluster. If enabled, pods must be valid under a PodSecurityPolicy to be created. Pod Security Policy was removed from GKE clusters with version >= 1.25.0. | `bool` | `false` | no |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | (Beta) Whether the master's internal IP address is used as the cluster endpoint | `bool` | `false` | no |
| <a name="input_enable_private_nodes"></a> [enable\_private\_nodes](#input\_enable\_private\_nodes) | (Beta) Whether nodes have internal IP addresses only | `bool` | `false` | no |
| <a name="input_enable_resource_consumption_export"></a> [enable\_resource\_consumption\_export](#input\_enable\_resource\_consumption\_export) | Whether to enable resource consumption metering on this cluster. When enabled, a table will be created in the resource export BigQuery dataset to store resource consumption data. The resulting table can be joined with the resource usage table or with BigQuery billing export. | `bool` | `true` | no |
| <a name="input_enable_shielded_nodes"></a> [enable\_shielded\_nodes](#input\_enable\_shielded\_nodes) | Enable Shielded Nodes features on all nodes in this cluster | `bool` | `true` | no |
| <a name="input_enable_tpu"></a> [enable\_tpu](#input\_enable\_tpu) | Enable Cloud TPU resources in the cluster. WARNING: changing this after cluster creation is destructive! | `bool` | `false` | no |
| <a name="input_enable_vertical_pod_autoscaling"></a> [enable\_vertical\_pod\_autoscaling](#input\_enable\_vertical\_pod\_autoscaling) | Vertical Pod Autoscaling automatically adjusts the resources of pods controlled by it | `bool` | `false` | no |
| <a name="input_filestore_csi_driver"></a> [filestore\_csi\_driver](#input\_filestore\_csi\_driver) | The status of the Filestore CSI driver addon, which allows the usage of filestore instance as volumes | `bool` | `false` | no |
| <a name="input_firewall_inbound_ports"></a> [firewall\_inbound\_ports](#input\_firewall\_inbound\_ports) | List of TCP ports for admission/webhook controllers. Either flag `add_master_webhook_firewall_rules` or `add_cluster_firewall_rules` (also adds egress rules) must be set to `true` for inbound-ports firewall rules to be applied. | `list(string)` | <pre>[<br>  "8443",<br>  "9443",<br>  "15017"<br>]</pre> | no |
| <a name="input_firewall_priority"></a> [firewall\_priority](#input\_firewall\_priority) | Priority rule for firewall rules | `number` | `1000` | no |
| <a name="input_fleet_project"></a> [fleet\_project](#input\_fleet\_project) | (Optional) Register the cluster with the fleet in this project. | `string` | `null` | no |
| <a name="input_fleet_project_grant_service_agent"></a> [fleet\_project\_grant\_service\_agent](#input\_fleet\_project\_grant\_service\_agent) | (Optional) Grant the fleet project service identity the `roles/gkehub.serviceAgent` and `roles/gkehub.crossProjectServiceAgent` roles. | `bool` | `false` | no |
| <a name="input_gateway_api_channel"></a> [gateway\_api\_channel](#input\_gateway\_api\_channel) | The gateway api channel of this cluster. Accepted values are `CHANNEL_STANDARD` and `CHANNEL_DISABLED`. | `string` | `null` | no |
| <a name="input_gce_pd_csi_driver"></a> [gce\_pd\_csi\_driver](#input\_gce\_pd\_csi\_driver) | Whether this cluster should enable the Google Compute Engine Persistent Disk Container Storage Interface (CSI) Driver. | `bool` | `true` | no |
| <a name="input_gcs_fuse_csi_driver"></a> [gcs\_fuse\_csi\_driver](#input\_gcs\_fuse\_csi\_driver) | Whether GCE FUSE CSI driver is enabled for this cluster. | `bool` | `false` | no |
| <a name="input_gke_backup_agent_config"></a> [gke\_backup\_agent\_config](#input\_gke\_backup\_agent\_config) | Whether Backup for GKE agent is enabled for this cluster. | `bool` | `false` | no |
| <a name="input_grant_registry_access"></a> [grant\_registry\_access](#input\_grant\_registry\_access) | Grants created cluster-specific service account storage.objectViewer and artifactregistry.reader roles. | `bool` | `false` | no |
| <a name="input_horizontal_pod_autoscaling"></a> [horizontal\_pod\_autoscaling](#input\_horizontal\_pod\_autoscaling) | Enable horizontal pod autoscaling addon | `bool` | `true` | no |
| <a name="input_http_load_balancing"></a> [http\_load\_balancing](#input\_http\_load\_balancing) | Enable httpload balancer addon | `bool` | `true` | no |
| <a name="input_identity_namespace"></a> [identity\_namespace](#input\_identity\_namespace) | The workload pool to attach all Kubernetes service accounts to. (Default value of `enabled` automatically sets project-based pool `[project_id].svc.id.goog`) | `string` | `"enabled"` | no |
| <a name="input_initial_node_count"></a> [initial\_node\_count](#input\_initial\_node\_count) | The number of nodes to create in this cluster's default node pool. | `number` | `0` | no |
| <a name="input_ip_masq_link_local"></a> [ip\_masq\_link\_local](#input\_ip\_masq\_link\_local) | Whether to masquerade traffic to the link-local prefix (169.254.0.0/16). | `bool` | `false` | no |
| <a name="input_ip_masq_resync_interval"></a> [ip\_masq\_resync\_interval](#input\_ip\_masq\_resync\_interval) | The interval at which the agent attempts to sync its ConfigMap file from the disk. | `string` | `"60s"` | no |
| <a name="input_ip_range_pods"></a> [ip\_range\_pods](#input\_ip\_range\_pods) | The _name_ of the secondary subnet ip range to use for pods | `string` | n/a | yes |
| <a name="input_ip_range_services"></a> [ip\_range\_services](#input\_ip\_range\_services) | The _name_ of the secondary subnet range to use for services | `string` | n/a | yes |
| <a name="input_issue_client_certificate"></a> [issue\_client\_certificate](#input\_issue\_client\_certificate) | Issues a client certificate to authenticate to the cluster endpoint. To maximize the security of your cluster, leave this option disabled. Client certificates don't automatically rotate and aren't easily revocable. WARNING: changing this after cluster creation is destructive! | `bool` | `false` | no |
| <a name="input_istio"></a> [istio](#input\_istio) | (Beta) Enable Istio addon | `bool` | `false` | no |
| <a name="input_istio_auth"></a> [istio\_auth](#input\_istio\_auth) | (Beta) The authentication type between services in Istio. | `string` | `"AUTH_MUTUAL_TLS"` | no |
| <a name="input_kalm_config"></a> [kalm\_config](#input\_kalm\_config) | (Beta) Whether KALM is enabled for this cluster. | `bool` | `false` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The Kubernetes version of the masters. If set to 'latest' it will pull latest available version in the selected region. | `string` | `"latest"` | no |
| <a name="input_logging_enabled_components"></a> [logging\_enabled\_components](#input\_logging\_enabled\_components) | List of services to monitor: SYSTEM\_COMPONENTS, WORKLOADS. Empty list is default GKE configuration. | `list(string)` | `[]` | no |
| <a name="input_logging_service"></a> [logging\_service](#input\_logging\_service) | The logging service that the cluster should write logs to. Available options include logging.googleapis.com, logging.googleapis.com/kubernetes (beta), and none | `string` | `"logging.googleapis.com/kubernetes"` | no |
| <a name="input_maintenance_end_time"></a> [maintenance\_end\_time](#input\_maintenance\_end\_time) | Time window specified for recurring maintenance operations in RFC3339 format | `string` | `""` | no |
| <a name="input_maintenance_exclusions"></a> [maintenance\_exclusions](#input\_maintenance\_exclusions) | List of maintenance exclusions. A cluster can have up to three | `list(object({ name = string, start_time = string, end_time = string, exclusion_scope = string }))` | `[]` | no |
| <a name="input_maintenance_recurrence"></a> [maintenance\_recurrence](#input\_maintenance\_recurrence) | Frequency of the recurring maintenance window in RFC5545 format. | `string` | `""` | no |
| <a name="input_maintenance_start_time"></a> [maintenance\_start\_time](#input\_maintenance\_start\_time) | Time window specified for daily or recurring maintenance operations in RFC3339 format | `string` | `"05:00"` | no |
| <a name="input_master_authorized_networks"></a> [master\_authorized\_networks](#input\_master\_authorized\_networks) | List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists). | `list(object({ cidr_block = string, display_name = string }))` | `[]` | no |
| <a name="input_master_global_access_enabled"></a> [master\_global\_access\_enabled](#input\_master\_global\_access\_enabled) | Whether the cluster master is accessible globally (from any region) or only within the same region as the private endpoint. | `bool` | `true` | no |
| <a name="input_master_ipv4_cidr_block"></a> [master\_ipv4\_cidr\_block](#input\_master\_ipv4\_cidr\_block) | (Beta) The IP range in CIDR notation to use for the hosted master network. Optional for Autopilot clusters. | `string` | `"10.0.0.0/28"` | no |
| <a name="input_monitoring_enable_managed_prometheus"></a> [monitoring\_enable\_managed\_prometheus](#input\_monitoring\_enable\_managed\_prometheus) | Configuration for Managed Service for Prometheus. Whether or not the managed collection is enabled. | `bool` | `false` | no |
| <a name="input_monitoring_enable_observability_metrics"></a> [monitoring\_enable\_observability\_metrics](#input\_monitoring\_enable\_observability\_metrics) | Whether or not the advanced datapath metrics are enabled. | `bool` | `false` | no |
| <a name="input_monitoring_enabled_components"></a> [monitoring\_enabled\_components](#input\_monitoring\_enabled\_components) | List of services to monitor: SYSTEM\_COMPONENTS, WORKLOADS. Empty list is default GKE configuration. | `list(string)` | `[]` | no |
| <a name="input_monitoring_observability_metrics_relay_mode"></a> [monitoring\_observability\_metrics\_relay\_mode](#input\_monitoring\_observability\_metrics\_relay\_mode) | Mode used to make advanced datapath metrics relay available. | `string` | `null` | no |
| <a name="input_monitoring_service"></a> [monitoring\_service](#input\_monitoring\_service) | The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting Available options include monitoring.googleapis.com, monitoring.googleapis.com/kubernetes (beta) and none | `string` | `"monitoring.googleapis.com/kubernetes"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the cluster (required) | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | The VPC network to host the cluster in (required) | `string` | n/a | yes |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | Enable network policy addon | `bool` | `false` | no |
| <a name="input_network_policy_provider"></a> [network\_policy\_provider](#input\_network\_policy\_provider) | The network policy provider. | `string` | `"CALICO"` | no |
| <a name="input_network_project_id"></a> [network\_project\_id](#input\_network\_project\_id) | The project ID of the shared VPC's host (for shared vpc support) | `string` | `""` | no |
| <a name="input_network_tags"></a> [network\_tags](#input\_network\_tags) | (Optional) - List of network tags applied to auto-provisioned node pools. | `list(string)` | `[]` | no |
| <a name="input_node_metadata"></a> [node\_metadata](#input\_node\_metadata) | Specifies how node metadata is exposed to the workload running on the node | `string` | `"GKE_METADATA"` | no |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | List of maps containing node pools | `list(map(any))` | <pre>[<br>  {<br>    "name": "default-node-pool"<br>  }<br>]</pre> | no |
| <a name="input_node_pools_labels"></a> [node\_pools\_labels](#input\_node\_pools\_labels) | Map of maps containing node labels by node-pool name | `map(map(string))` | <pre>{<br>  "all": {},<br>  "default-node-pool": {}<br>}</pre> | no |
| <a name="input_node_pools_linux_node_configs_sysctls"></a> [node\_pools\_linux\_node\_configs\_sysctls](#input\_node\_pools\_linux\_node\_configs\_sysctls) | Map of maps containing linux node config sysctls by node-pool name | `map(map(string))` | <pre>{<br>  "all": {},<br>  "default-node-pool": {}<br>}</pre> | no |
| <a name="input_node_pools_metadata"></a> [node\_pools\_metadata](#input\_node\_pools\_metadata) | Map of maps containing node metadata by node-pool name | `map(map(string))` | <pre>{<br>  "all": {},<br>  "default-node-pool": {}<br>}</pre> | no |
| <a name="input_node_pools_oauth_scopes"></a> [node\_pools\_oauth\_scopes](#input\_node\_pools\_oauth\_scopes) | Map of lists containing node oauth scopes by node-pool name | `map(list(string))` | <pre>{<br>  "all": [<br>    "https://www.googleapis.com/auth/cloud-platform"<br>  ],<br>  "default-node-pool": []<br>}</pre> | no |
| <a name="input_node_pools_resource_labels"></a> [node\_pools\_resource\_labels](#input\_node\_pools\_resource\_labels) | Map of maps containing resource labels by node-pool name | `map(map(string))` | <pre>{<br>  "all": {},<br>  "default-node-pool": {}<br>}</pre> | no |
| <a name="input_node_pools_tags"></a> [node\_pools\_tags](#input\_node\_pools\_tags) | Map of lists containing node network tags by node-pool name | `map(list(string))` | <pre>{<br>  "all": [],<br>  "default-node-pool": []<br>}</pre> | no |
| <a name="input_node_pools_taints"></a> [node\_pools\_taints](#input\_node\_pools\_taints) | Map of lists containing node taints by node-pool name | `map(list(object({ key = string, value = string, effect = string })))` | <pre>{<br>  "all": [],<br>  "default-node-pool": []<br>}</pre> | no |
| <a name="input_non_masquerade_cidrs"></a> [non\_masquerade\_cidrs](#input\_non\_masquerade\_cidrs) | List of strings in CIDR notation that specify the IP address ranges that do not use IP masquerading. | `list(string)` | <pre>[<br>  "10.0.0.0/8",<br>  "172.16.0.0/12",<br>  "192.168.0.0/16"<br>]</pre> | no |
| <a name="input_notification_config_topic"></a> [notification\_config\_topic](#input\_notification\_config\_topic) | The desired Pub/Sub topic to which notifications will be sent by GKE. Format is projects/{project}/topics/{topic}. | `string` | `""` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to host the cluster in (required) | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to host the cluster in (optional if zonal cluster / required if regional) | `string` | `null` | no |
| <a name="input_regional"></a> [regional](#input\_regional) | Whether is a regional cluster (zonal cluster if set false. WARNING: changing this after cluster creation is destructive!) | `bool` | `true` | no |
| <a name="input_registry_project_ids"></a> [registry\_project\_ids](#input\_registry\_project\_ids) | Projects holding Google Container Registries. If empty, we use the cluster project. If a service account is created and the `grant_registry_access` variable is set to `true`, the `storage.objectViewer` and `artifactregsitry.reader` roles are assigned on these projects. | `list(string)` | `[]` | no |
| <a name="input_release_channel"></a> [release\_channel](#input\_release\_channel) | The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `REGULAR`. | `string` | `"REGULAR"` | no |
| <a name="input_remove_default_node_pool"></a> [remove\_default\_node\_pool](#input\_remove\_default\_node\_pool) | Remove default node pool while setting up the cluster | `bool` | `false` | no |
| <a name="input_resource_usage_export_dataset_id"></a> [resource\_usage\_export\_dataset\_id](#input\_resource\_usage\_export\_dataset\_id) | The ID of a BigQuery Dataset for using BigQuery as the destination of resource usage export. | `string` | `""` | no |
| <a name="input_sandbox_enabled"></a> [sandbox\_enabled](#input\_sandbox\_enabled) | (Beta) Enable GKE Sandbox (Do not forget to set `image_type` = `COS_CONTAINERD` to use it). | `bool` | `false` | no |
| <a name="input_security_posture_mode"></a> [security\_posture\_mode](#input\_security\_posture\_mode) | Security posture mode.  Accepted values are `DISABLED` and `BASIC`. Defaults to `DISABLED`. | `string` | `"DISABLED"` | no |
| <a name="input_security_posture_vulnerability_mode"></a> [security\_posture\_vulnerability\_mode](#input\_security\_posture\_vulnerability\_mode) | Security posture vulnerability mode.  Accepted values are `VULNERABILITY_DISABLED` and `VULNERABILITY_BASIC`. Defaults to `VULNERABILITY_DISABLED`. | `string` | `"VULNERABILITY_DISABLED"` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | The service account to run nodes as if not overridden in `node_pools`. The create\_service\_account variable default value (true) will cause a cluster-specific service account to be created. This service account should already exists and it will be used by the node pools. If you wish to only override the service account name, you can use service\_account\_name variable. | `string` | `""` | no |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | The name of the service account that will be created if create\_service\_account is true. If you wish to use an existing service account, use service\_account variable. | `string` | `""` | no |
| <a name="input_service_external_ips"></a> [service\_external\_ips](#input\_service\_external\_ips) | Whether external ips specified by a service will be allowed in this cluster | `bool` | `false` | no |
| <a name="input_shadow_firewall_rules_log_config"></a> [shadow\_firewall\_rules\_log\_config](#input\_shadow\_firewall\_rules\_log\_config) | The log\_config for shadow firewall rules. You can set this variable to `null` to disable logging. | <pre>object({<br>    metadata = string<br>  })</pre> | <pre>{<br>  "metadata": "INCLUDE_ALL_METADATA"<br>}</pre> | no |
| <a name="input_shadow_firewall_rules_priority"></a> [shadow\_firewall\_rules\_priority](#input\_shadow\_firewall\_rules\_priority) | The firewall priority of GKE shadow firewall rules. The priority should be less than default firewall, which is 1000. | `number` | `999` | no |
| <a name="input_stack_type"></a> [stack\_type](#input\_stack\_type) | The stack type to use for this cluster. Either `IPV4` or `IPV4_IPV6`. Defaults to `IPV4`. | `string` | `"IPV4"` | no |
| <a name="input_stub_domains"></a> [stub\_domains](#input\_stub\_domains) | Map of stub domains and their resolvers to forward DNS queries for a certain domain to an external DNS server | `map(list(string))` | `{}` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | The subnetwork to host the cluster in (required) | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Timeout for cluster operations. | `map(string)` | `{}` | no |
| <a name="input_upstream_nameservers"></a> [upstream\_nameservers](#input\_upstream\_nameservers) | If specified, the values replace the nameservers taken by default from the node’s /etc/resolv.conf | `list(string)` | `[]` | no |
| <a name="input_windows_node_pools"></a> [windows\_node\_pools](#input\_windows\_node\_pools) | List of maps containing Windows node pools | `list(map(string))` | `[]` | no |
| <a name="input_workload_config_audit_mode"></a> [workload\_config\_audit\_mode](#input\_workload\_config\_audit\_mode) | (beta) Workload config audit mode. | `string` | `"DISABLED"` | no |
| <a name="input_workload_vulnerability_mode"></a> [workload\_vulnerability\_mode](#input\_workload\_vulnerability\_mode) | (beta) Vulnerability mode. | `string` | `""` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | The zones to host the cluster in (optional if regional cluster / required if zonal) | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ca_certificate"></a> [ca\_certificate](#output\_ca\_certificate) | Cluster ca certificate (base64 encoded) |
| <a name="output_cloudrun_enabled"></a> [cloudrun\_enabled](#output\_cloudrun\_enabled) | Whether CloudRun enabled |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | Cluster ID |
| <a name="output_dns_cache_enabled"></a> [dns\_cache\_enabled](#output\_dns\_cache\_enabled) | Whether DNS Cache enabled |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | Cluster endpoint |
| <a name="output_fleet_membership"></a> [fleet\_membership](#output\_fleet\_membership) | Fleet membership (if registered) |
| <a name="output_gateway_api_channel"></a> [gateway\_api\_channel](#output\_gateway\_api\_channel) | The gateway api channel of this cluster. |
| <a name="output_horizontal_pod_autoscaling_enabled"></a> [horizontal\_pod\_autoscaling\_enabled](#output\_horizontal\_pod\_autoscaling\_enabled) | Whether horizontal pod autoscaling enabled |
| <a name="output_http_load_balancing_enabled"></a> [http\_load\_balancing\_enabled](#output\_http\_load\_balancing\_enabled) | Whether http load balancing enabled |
| <a name="output_identity_namespace"></a> [identity\_namespace](#output\_identity\_namespace) | Workload Identity pool |
| <a name="output_identity_service_enabled"></a> [identity\_service\_enabled](#output\_identity\_service\_enabled) | Whether Identity Service is enabled |
| <a name="output_instance_group_urls"></a> [instance\_group\_urls](#output\_instance\_group\_urls) | List of GKE generated instance groups |
| <a name="output_intranode_visibility_enabled"></a> [intranode\_visibility\_enabled](#output\_intranode\_visibility\_enabled) | Whether intra-node visibility is enabled |
| <a name="output_istio_enabled"></a> [istio\_enabled](#output\_istio\_enabled) | Whether Istio is enabled |
| <a name="output_location"></a> [location](#output\_location) | Cluster location (region if regional cluster, zone if zonal cluster) |
| <a name="output_logging_service"></a> [logging\_service](#output\_logging\_service) | Logging service used |
| <a name="output_master_authorized_networks_config"></a> [master\_authorized\_networks\_config](#output\_master\_authorized\_networks\_config) | Networks from which access to master is permitted |
| <a name="output_master_ipv4_cidr_block"></a> [master\_ipv4\_cidr\_block](#output\_master\_ipv4\_cidr\_block) | The IP range in CIDR notation used for the hosted master network |
| <a name="output_master_version"></a> [master\_version](#output\_master\_version) | Current master kubernetes version |
| <a name="output_mesh_certificates_config"></a> [mesh\_certificates\_config](#output\_mesh\_certificates\_config) | Mesh certificates configuration |
| <a name="output_min_master_version"></a> [min\_master\_version](#output\_min\_master\_version) | Minimum master kubernetes version |
| <a name="output_monitoring_service"></a> [monitoring\_service](#output\_monitoring\_service) | Monitoring service used |
| <a name="output_name"></a> [name](#output\_name) | Cluster name |
| <a name="output_network_policy_enabled"></a> [network\_policy\_enabled](#output\_network\_policy\_enabled) | Whether network policy enabled |
| <a name="output_node_pools_names"></a> [node\_pools\_names](#output\_node\_pools\_names) | List of node pools names |
| <a name="output_node_pools_versions"></a> [node\_pools\_versions](#output\_node\_pools\_versions) | Node pool versions by node pool name |
| <a name="output_peering_name"></a> [peering\_name](#output\_peering\_name) | The name of the peering between this cluster and the Google owned VPC. |
| <a name="output_pod_security_policy_enabled"></a> [pod\_security\_policy\_enabled](#output\_pod\_security\_policy\_enabled) | Whether pod security policy is enabled |
| <a name="output_region"></a> [region](#output\_region) | Cluster region |
| <a name="output_release_channel"></a> [release\_channel](#output\_release\_channel) | The release channel of this cluster |
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | The service account to default running nodes as if not overridden in `node_pools`. |
| <a name="output_tpu_ipv4_cidr_block"></a> [tpu\_ipv4\_cidr\_block](#output\_tpu\_ipv4\_cidr\_block) | The IP range in CIDR notation used for the TPUs |
| <a name="output_type"></a> [type](#output\_type) | Cluster type (regional / zonal) |
| <a name="output_vertical_pod_autoscaling_enabled"></a> [vertical\_pod\_autoscaling\_enabled](#output\_vertical\_pod\_autoscaling\_enabled) | Whether vertical pod autoscaling enabled |
| <a name="output_zones"></a> [zones](#output\_zones) | List of zones in which the cluster resides |
<!-- END_TF_DOCS -->