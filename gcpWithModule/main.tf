provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
  credentials = file("/Users/nitish/Desktop/nitish/terraform/terraform-sa-key.json")
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_name = var.vpc_name
}
