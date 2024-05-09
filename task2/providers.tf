terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.27.0"
    }
  }
}

provider "google" {
  # Configuration options
  project     = "composed-garden-417100"
  region      = "us-east1"
  zone        = "us-east1-b"
  credentials = "composed-garden-417100-222f824cdc74.json"
}