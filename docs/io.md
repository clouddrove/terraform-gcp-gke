## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| add\_cluster\_firewall\_rules | Create additional firewall rules | `bool` | `false` | no |
| add\_master\_webhook\_firewall\_rules | Create master\_webhook firewall rules for ports defined in `firewall_inbound_ports` | `bool` | `false` | no |
| add\_shadow\_firewall\_rules | Create GKE shadow firewall (the same as default firewall rules with firewall logs enabled). | `bool` | `false` | no |
| additional\_ip\_range\_pods | List of _names_ of the additional secondary subnet ip ranges to use for pods | `list(string)` | `[]` | no |
| authenticator\_security\_group | The name of the RBAC security group for use with Google security groups in Kubernetes RBAC. Group name must be in format gke-security-groups@yourdomain.com | `string` | `null` | no |
| cloudrun | (Beta) Enable CloudRun addon | `bool` | `false` | no |
| cloudrun\_load\_balancer\_type | (Beta) Configure the Cloud Run load balancer type. External by default. Set to `LOAD_BALANCER_TYPE_INTERNAL` to configure as an internal load balancer. | `string` | `""` | no |
| cluster\_autoscaling | Cluster autoscaling configuration. See [more details](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1beta1/projects.locations.clusters#clusterautoscaling) | <pre>object({<br>    enabled             = bool<br>    autoscaling_profile = string<br>    min_cpu_cores       = number<br>    max_cpu_cores       = number<br>    min_memory_gb       = number<br>    max_memory_gb       = number<br>    gpu_resources       = list(object({ resource_type = string, minimum = number, maximum = number }))<br>    auto_repair         = bool<br>    auto_upgrade        = bool<br>    disk_size           = optional(number)<br>    disk_type           = optional(string)<br>  })</pre> | <pre>{<br>  "auto_repair": true,<br>  "auto_upgrade": true,<br>  "autoscaling_profile": "BALANCED",<br>  "disk_size": 100,<br>  "disk_type": "pd-standard",<br>  "enabled": false,<br>  "gpu_resources": [],<br>  "max_cpu_cores": 0,<br>  "max_memory_gb": 0,<br>  "min_cpu_cores": 0,<br>  "min_memory_gb": 0<br>}</pre> | no |
| cluster\_dns\_domain | The suffix used for all cluster service records. | `string` | `""` | no |
| cluster\_dns\_provider | Which in-cluster DNS provider should be used. PROVIDER\_UNSPECIFIED (default) or PLATFORM\_DEFAULT or CLOUD\_DNS. | `string` | `"PROVIDER_UNSPECIFIED"` | no |
| cluster\_dns\_scope | The scope of access to cluster DNS records. DNS\_SCOPE\_UNSPECIFIED (default) or CLUSTER\_SCOPE or VPC\_SCOPE. | `string` | `"DNS_SCOPE_UNSPECIFIED"` | no |
| cluster\_ipv4\_cidr | The IP address range of the kubernetes pods in this cluster. Default is an automatically assigned CIDR. | `string` | `null` | no |
| cluster\_resource\_labels | The GCE resource labels (a map of key/value pairs) to be applied to the cluster | `map(string)` | `{}` | no |
| cluster\_telemetry\_type | Available options include ENABLED, DISABLED, and SYSTEM\_ONLY | `string` | `null` | no |
| config\_connector | Whether ConfigConnector is enabled for this cluster. | `bool` | `false` | no |
| configure\_ip\_masq | Enables the installation of ip masquerading, which is usually no longer required when using aliasied IP addresses. IP masquerading uses a kubectl call, so when you have a private cluster, you will need access to the API server. | `bool` | `false` | no |
| create\_service\_account | Defines if service account specified to run nodes should be created. | `bool` | `true` | no |
| database\_encryption | Application-layer Secrets Encryption settings. The object format is {state = string, key\_name = string}. Valid values of state are: "ENCRYPTED"; "DECRYPTED". key\_name is the name of a CloudKMS key. | `list(object({ state = string, key_name = string }))` | <pre>[<br>  {<br>    "key_name": "",<br>    "state": "DECRYPTED"<br>  }<br>]</pre> | no |
| datapath\_provider | The desired datapath provider for this cluster. By default, `DATAPATH_PROVIDER_UNSPECIFIED` enables the IPTables-based kube-proxy implementation. `ADVANCED_DATAPATH` enables Dataplane-V2 feature. | `string` | `"DATAPATH_PROVIDER_UNSPECIFIED"` | no |
| default\_max\_pods\_per\_node | The maximum number of pods to schedule per node | `number` | `110` | no |
| deletion\_protection | Whether or not to allow Terraform to destroy the cluster. | `bool` | `true` | no |
| deploy\_using\_private\_endpoint | (Beta) A toggle for Terraform and kubectl to connect to the master's internal IP address during deployment. | `bool` | `false` | no |
| description | The description of the cluster | `string` | `""` | no |
| disable\_default\_snat | Whether to disable the default SNAT to support the private use of public IP addresses | `bool` | `false` | no |
| disable\_legacy\_metadata\_endpoints | Disable the /0.1/ and /v1beta1/ metadata server endpoints on the node. Changing this value will cause all node pools to be recreated. | `bool` | `true` | no |
| dns\_cache | The status of the NodeLocal DNSCache addon. | `bool` | `false` | no |
| enable\_binary\_authorization | Enable BinAuthZ Admission controller | `bool` | `false` | no |
| enable\_confidential\_nodes | An optional flag to enable confidential node config. | `bool` | `false` | no |
| enable\_cost\_allocation | Enables Cost Allocation Feature and the cluster name and namespace of your GKE workloads appear in the labels field of the billing export to BigQuery | `bool` | `false` | no |
| enable\_fqdn\_network\_policy | Enable FQDN Network Policies on the cluster | `bool` | `null` | no |
| enable\_gcfs | Enable image streaming on cluster level. | `bool` | `false` | no |
| enable\_identity\_service | Enable the Identity Service component, which allows customers to use external identity providers with the K8S API. | `bool` | `false` | no |
| enable\_intranode\_visibility | Whether Intra-node visibility is enabled for this cluster. This makes same node pod to pod traffic visible for VPC network | `bool` | `false` | no |
| enable\_kubernetes\_alpha | Whether to enable Kubernetes Alpha features for this cluster. Note that when this option is enabled, the cluster cannot be upgraded and will be automatically deleted after 30 days. | `bool` | `false` | no |
| enable\_l4\_ilb\_subsetting | Enable L4 ILB Subsetting on the cluster | `bool` | `false` | no |
| enable\_mesh\_certificates | Controls the issuance of workload mTLS certificates. When enabled the GKE Workload Identity Certificates controller and node agent will be deployed in the cluster. Requires Workload Identity. | `bool` | `false` | no |
| enable\_network\_egress\_export | Whether to enable network egress metering for this cluster. If enabled, a daemonset will be created in the cluster to meter network egress traffic. | `bool` | `false` | no |
| enable\_pod\_security\_policy | enabled - Enable the PodSecurityPolicy controller for this cluster. If enabled, pods must be valid under a PodSecurityPolicy to be created. Pod Security Policy was removed from GKE clusters with version >= 1.25.0. | `bool` | `false` | no |
| enable\_private\_endpoint | (Beta) Whether the master's internal IP address is used as the cluster endpoint | `bool` | `false` | no |
| enable\_private\_nodes | (Beta) Whether nodes have internal IP addresses only | `bool` | `false` | no |
| enable\_resource\_consumption\_export | Whether to enable resource consumption metering on this cluster. When enabled, a table will be created in the resource export BigQuery dataset to store resource consumption data. The resulting table can be joined with the resource usage table or with BigQuery billing export. | `bool` | `true` | no |
| enable\_shielded\_nodes | Enable Shielded Nodes features on all nodes in this cluster | `bool` | `true` | no |
| enable\_tpu | Enable Cloud TPU resources in the cluster. WARNING: changing this after cluster creation is destructive! | `bool` | `false` | no |
| enable\_vertical\_pod\_autoscaling | Vertical Pod Autoscaling automatically adjusts the resources of pods controlled by it | `bool` | `false` | no |
| filestore\_csi\_driver | The status of the Filestore CSI driver addon, which allows the usage of filestore instance as volumes | `bool` | `false` | no |
| firewall\_inbound\_ports | List of TCP ports for admission/webhook controllers. Either flag `add_master_webhook_firewall_rules` or `add_cluster_firewall_rules` (also adds egress rules) must be set to `true` for inbound-ports firewall rules to be applied. | `list(string)` | <pre>[<br>  "8443",<br>  "9443",<br>  "15017"<br>]</pre> | no |
| firewall\_priority | Priority rule for firewall rules | `number` | `1000` | no |
| fleet\_project | (Optional) Register the cluster with the fleet in this project. | `string` | `null` | no |
| fleet\_project\_grant\_service\_agent | (Optional) Grant the fleet project service identity the `roles/gkehub.serviceAgent` and `roles/gkehub.crossProjectServiceAgent` roles. | `bool` | `false` | no |
| gateway\_api\_channel | The gateway api channel of this cluster. Accepted values are `CHANNEL_STANDARD` and `CHANNEL_DISABLED`. | `string` | `null` | no |
| gce\_pd\_csi\_driver | Whether this cluster should enable the Google Compute Engine Persistent Disk Container Storage Interface (CSI) Driver. | `bool` | `true` | no |
| gcs\_fuse\_csi\_driver | Whether GCE FUSE CSI driver is enabled for this cluster. | `bool` | `false` | no |
| gke\_backup\_agent\_config | Whether Backup for GKE agent is enabled for this cluster. | `bool` | `false` | no |
| grant\_registry\_access | Grants created cluster-specific service account storage.objectViewer and artifactregistry.reader roles. | `bool` | `false` | no |
| horizontal\_pod\_autoscaling | Enable horizontal pod autoscaling addon | `bool` | `true` | no |
| http\_load\_balancing | Enable httpload balancer addon | `bool` | `true` | no |
| identity\_namespace | The workload pool to attach all Kubernetes service accounts to. (Default value of `enabled` automatically sets project-based pool `[project_id].svc.id.goog`) | `string` | `"enabled"` | no |
| initial\_node\_count | The number of nodes to create in this cluster's default node pool. | `number` | `0` | no |
| ip\_masq\_link\_local | Whether to masquerade traffic to the link-local prefix (169.254.0.0/16). | `bool` | `false` | no |
| ip\_masq\_resync\_interval | The interval at which the agent attempts to sync its ConfigMap file from the disk. | `string` | `"60s"` | no |
| ip\_range\_pods | The _name_ of the secondary subnet ip range to use for pods | `string` | n/a | yes |
| ip\_range\_services | The _name_ of the secondary subnet range to use for services | `string` | n/a | yes |
| issue\_client\_certificate | Issues a client certificate to authenticate to the cluster endpoint. To maximize the security of your cluster, leave this option disabled. Client certificates don't automatically rotate and aren't easily revocable. WARNING: changing this after cluster creation is destructive! | `bool` | `false` | no |
| istio | (Beta) Enable Istio addon | `bool` | `false` | no |
| istio\_auth | (Beta) The authentication type between services in Istio. | `string` | `"AUTH_MUTUAL_TLS"` | no |
| kalm\_config | (Beta) Whether KALM is enabled for this cluster. | `bool` | `false` | no |
| kubernetes\_version | The Kubernetes version of the masters. If set to 'latest' it will pull latest available version in the selected region. | `string` | `"latest"` | no |
| logging\_enabled\_components | List of services to monitor: SYSTEM\_COMPONENTS, WORKLOADS. Empty list is default GKE configuration. | `list(string)` | `[]` | no |
| logging\_service | The logging service that the cluster should write logs to. Available options include logging.googleapis.com, logging.googleapis.com/kubernetes (beta), and none | `string` | `"logging.googleapis.com/kubernetes"` | no |
| maintenance\_end\_time | Time window specified for recurring maintenance operations in RFC3339 format | `string` | `""` | no |
| maintenance\_exclusions | List of maintenance exclusions. A cluster can have up to three | `list(object({ name = string, start_time = string, end_time = string, exclusion_scope = string }))` | `[]` | no |
| maintenance\_recurrence | Frequency of the recurring maintenance window in RFC5545 format. | `string` | `""` | no |
| maintenance\_start\_time | Time window specified for daily or recurring maintenance operations in RFC3339 format | `string` | `"05:00"` | no |
| master\_authorized\_networks | List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists). | `list(object({ cidr_block = string, display_name = string }))` | `[]` | no |
| master\_global\_access\_enabled | Whether the cluster master is accessible globally (from any region) or only within the same region as the private endpoint. | `bool` | `true` | no |
| master\_ipv4\_cidr\_block | (Beta) The IP range in CIDR notation to use for the hosted master network. Optional for Autopilot clusters. | `string` | `"10.0.0.0/28"` | no |
| monitoring\_enable\_managed\_prometheus | Configuration for Managed Service for Prometheus. Whether or not the managed collection is enabled. | `bool` | `false` | no |
| monitoring\_enable\_observability\_metrics | Whether or not the advanced datapath metrics are enabled. | `bool` | `false` | no |
| monitoring\_enabled\_components | List of services to monitor: SYSTEM\_COMPONENTS, WORKLOADS. Empty list is default GKE configuration. | `list(string)` | `[]` | no |
| monitoring\_observability\_metrics\_relay\_mode | Mode used to make advanced datapath metrics relay available. | `string` | `null` | no |
| monitoring\_service | The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Google Cloud Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting Available options include monitoring.googleapis.com, monitoring.googleapis.com/kubernetes (beta) and none | `string` | `"monitoring.googleapis.com/kubernetes"` | no |
| name | The name of the cluster (required) | `string` | n/a | yes |
| network | The VPC network to host the cluster in (required) | `string` | n/a | yes |
| network\_policy | Enable network policy addon | `bool` | `false` | no |
| network\_policy\_provider | The network policy provider. | `string` | `"CALICO"` | no |
| network\_project\_id | The project ID of the shared VPC's host (for shared vpc support) | `string` | `""` | no |
| network\_tags | (Optional) - List of network tags applied to auto-provisioned node pools. | `list(string)` | `[]` | no |
| node\_metadata | Specifies how node metadata is exposed to the workload running on the node | `string` | `"GKE_METADATA"` | no |
| node\_pools | List of maps containing node pools | `list(map(any))` | <pre>[<br>  {<br>    "name": "default-node-pool"<br>  }<br>]</pre> | no |
| node\_pools\_labels | Map of maps containing node labels by node-pool name | `map(map(string))` | <pre>{<br>  "all": {},<br>  "default-node-pool": {}<br>}</pre> | no |
| node\_pools\_linux\_node\_configs\_sysctls | Map of maps containing linux node config sysctls by node-pool name | `map(map(string))` | <pre>{<br>  "all": {},<br>  "default-node-pool": {}<br>}</pre> | no |
| node\_pools\_metadata | Map of maps containing node metadata by node-pool name | `map(map(string))` | <pre>{<br>  "all": {},<br>  "default-node-pool": {}<br>}</pre> | no |
| node\_pools\_oauth\_scopes | Map of lists containing node oauth scopes by node-pool name | `map(list(string))` | <pre>{<br>  "all": [<br>    "https://www.googleapis.com/auth/cloud-platform"<br>  ],<br>  "default-node-pool": []<br>}</pre> | no |
| node\_pools\_resource\_labels | Map of maps containing resource labels by node-pool name | `map(map(string))` | <pre>{<br>  "all": {},<br>  "default-node-pool": {}<br>}</pre> | no |
| node\_pools\_tags | Map of lists containing node network tags by node-pool name | `map(list(string))` | <pre>{<br>  "all": [],<br>  "default-node-pool": []<br>}</pre> | no |
| node\_pools\_taints | Map of lists containing node taints by node-pool name | `map(list(object({ key = string, value = string, effect = string })))` | <pre>{<br>  "all": [],<br>  "default-node-pool": []<br>}</pre> | no |
| non\_masquerade\_cidrs | List of strings in CIDR notation that specify the IP address ranges that do not use IP masquerading. | `list(string)` | <pre>[<br>  "10.0.0.0/8",<br>  "172.16.0.0/12",<br>  "192.168.0.0/16"<br>]</pre> | no |
| notification\_config\_topic | The desired Pub/Sub topic to which notifications will be sent by GKE. Format is projects/{project}/topics/{topic}. | `string` | `""` | no |
| project\_id | The project ID to host the cluster in (required) | `string` | n/a | yes |
| region | The region to host the cluster in (optional if zonal cluster / required if regional) | `string` | `null` | no |
| regional | Whether is a regional cluster (zonal cluster if set false. WARNING: changing this after cluster creation is destructive!) | `bool` | `true` | no |
| registry\_project\_ids | Projects holding Google Container Registries. If empty, we use the cluster project. If a service account is created and the `grant_registry_access` variable is set to `true`, the `storage.objectViewer` and `artifactregsitry.reader` roles are assigned on these projects. | `list(string)` | `[]` | no |
| release\_channel | The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `REGULAR`. | `string` | `"REGULAR"` | no |
| remove\_default\_node\_pool | Remove default node pool while setting up the cluster | `bool` | `false` | no |
| resource\_usage\_export\_dataset\_id | The ID of a BigQuery Dataset for using BigQuery as the destination of resource usage export. | `string` | `""` | no |
| sandbox\_enabled | (Beta) Enable GKE Sandbox (Do not forget to set `image_type` = `COS_CONTAINERD` to use it). | `bool` | `false` | no |
| security\_posture\_mode | Security posture mode.  Accepted values are `DISABLED` and `BASIC`. Defaults to `DISABLED`. | `string` | `"DISABLED"` | no |
| security\_posture\_vulnerability\_mode | Security posture vulnerability mode.  Accepted values are `VULNERABILITY_DISABLED` and `VULNERABILITY_BASIC`. Defaults to `VULNERABILITY_DISABLED`. | `string` | `"VULNERABILITY_DISABLED"` | no |
| service\_account | The service account to run nodes as if not overridden in `node_pools`. The create\_service\_account variable default value (true) will cause a cluster-specific service account to be created. This service account should already exists and it will be used by the node pools. If you wish to only override the service account name, you can use service\_account\_name variable. | `string` | `""` | no |
| service\_account\_name | The name of the service account that will be created if create\_service\_account is true. If you wish to use an existing service account, use service\_account variable. | `string` | `""` | no |
| service\_external\_ips | Whether external ips specified by a service will be allowed in this cluster | `bool` | `false` | no |
| shadow\_firewall\_rules\_log\_config | The log\_config for shadow firewall rules. You can set this variable to `null` to disable logging. | <pre>object({<br>    metadata = string<br>  })</pre> | <pre>{<br>  "metadata": "INCLUDE_ALL_METADATA"<br>}</pre> | no |
| shadow\_firewall\_rules\_priority | The firewall priority of GKE shadow firewall rules. The priority should be less than default firewall, which is 1000. | `number` | `999` | no |
| stack\_type | The stack type to use for this cluster. Either `IPV4` or `IPV4_IPV6`. Defaults to `IPV4`. | `string` | `"IPV4"` | no |
| stub\_domains | Map of stub domains and their resolvers to forward DNS queries for a certain domain to an external DNS server | `map(list(string))` | `{}` | no |
| subnetwork | The subnetwork to host the cluster in (required) | `string` | n/a | yes |
| timeouts | Timeout for cluster operations. | `map(string)` | `{}` | no |
| upstream\_nameservers | If specified, the values replace the nameservers taken by default from the node’s /etc/resolv.conf | `list(string)` | `[]` | no |
| windows\_node\_pools | List of maps containing Windows node pools | `list(map(string))` | `[]` | no |
| workload\_config\_audit\_mode | (beta) Workload config audit mode. | `string` | `"DISABLED"` | no |
| workload\_vulnerability\_mode | (beta) Vulnerability mode. | `string` | `""` | no |
| zones | The zones to host the cluster in (optional if regional cluster / required if zonal) | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| ca\_certificate | Cluster ca certificate (base64 encoded) |
| cloudrun\_enabled | Whether CloudRun enabled |
| cluster\_id | Cluster ID |
| dns\_cache\_enabled | Whether DNS Cache enabled |
| endpoint | Cluster endpoint |
| fleet\_membership | Fleet membership (if registered) |
| gateway\_api\_channel | The gateway api channel of this cluster. |
| horizontal\_pod\_autoscaling\_enabled | Whether horizontal pod autoscaling enabled |
| http\_load\_balancing\_enabled | Whether http load balancing enabled |
| identity\_namespace | Workload Identity pool |
| identity\_service\_enabled | Whether Identity Service is enabled |
| instance\_group\_urls | List of GKE generated instance groups |
| intranode\_visibility\_enabled | Whether intra-node visibility is enabled |
| istio\_enabled | Whether Istio is enabled |
| location | Cluster location (region if regional cluster, zone if zonal cluster) |
| logging\_service | Logging service used |
| master\_authorized\_networks\_config | Networks from which access to master is permitted |
| master\_ipv4\_cidr\_block | The IP range in CIDR notation used for the hosted master network |
| master\_version | Current master kubernetes version |
| mesh\_certificates\_config | Mesh certificates configuration |
| min\_master\_version | Minimum master kubernetes version |
| monitoring\_service | Monitoring service used |
| name | Cluster name |
| network\_policy\_enabled | Whether network policy enabled |
| node\_pools\_names | List of node pools names |
| node\_pools\_versions | Node pool versions by node pool name |
| peering\_name | The name of the peering between this cluster and the Google owned VPC. |
| pod\_security\_policy\_enabled | Whether pod security policy is enabled |
| region | Cluster region |
| release\_channel | The release channel of this cluster |
| service\_account | The service account to default running nodes as if not overridden in `node_pools`. |
| tpu\_ipv4\_cidr\_block | The IP range in CIDR notation used for the TPUs |
| type | Cluster type (regional / zonal) |
| vertical\_pod\_autoscaling\_enabled | Whether vertical pod autoscaling enabled |
| zones | List of zones in which the cluster resides |

