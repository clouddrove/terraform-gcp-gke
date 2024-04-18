terraform {
  required_version = ">= 1.4.6"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.22.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 5.25"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.29"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6"
    }
  }
}