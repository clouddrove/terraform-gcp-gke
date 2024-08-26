variable "environment" {
  type        = string
  default     = "account"
  description = "Environment name"
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. `name`,`application`."
}

variable "gcp_project_id" {
  type        = string
  default     = "clouddrove"
  description = "Google Cloud project ID"
}

variable "gcp_region" {
  type        = string
  default     = "europe-west3"
  description = "Google Cloud region"
}

variable "gcp_zone" {
  type        = string
  default     = "Europe-west3-c"
  description = "Google Cloud zone"
}

variable "location" {
  description = "The location (region or zone) of the GKE cluster."
  default     = "europe-west3"
  type        = string
}
