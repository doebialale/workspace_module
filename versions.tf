terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.25"
    }
    external = {
      version = "~> 2.1"
    }
    template = {
      version = "~> 2.2"
    }
  }
  required_version = "~> 1.0"
}