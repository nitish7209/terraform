terraform {
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "6.8.0"
    }
  }
}

provider "google" {
   project = var.project
   region = var.region
   zone = var.zone
   credentials = file("terraform-sa-key.json")
}

resource "google_compute_network" "vpc_network" {
    name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
   name = var.name
   machine_type = var.machine_type
   zone = var.zone
   tags = var.tags

   boot_disk {
     initialize_params {
       image = "debian-cloud/debian-11"
     }
   }

   network_interface {
     network = google_compute_network.vpc_network.name
     access_config {
       // Ephemeral public IP
     }
   }
}