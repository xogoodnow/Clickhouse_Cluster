terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.49.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
  }
  required_version = ">= 1.8.0"
}
