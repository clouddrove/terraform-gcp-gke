terraform {
  required_version = ">= 1.3, < 2.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.45.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      #version = ">= 6.45.0"
      version = ">= 5.9.0, < 7"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.38.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.7.2"
    }
  }
}
