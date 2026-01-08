terraform {
  backend "gcs" {
    bucket = "terraform-test-483707-tfstate"
    prefix = "gcp/network"
    credentials = "terraform-sa-key.json"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}
