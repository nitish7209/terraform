resource "google_compute_network" "this" {
  name                    = var.vpc_name
  auto_create_subnetworks = true
}
