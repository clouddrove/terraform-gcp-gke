terraform {
  required_version = ">=1.7.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.22.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 5.22.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.10"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.1"
    }
  }
}
