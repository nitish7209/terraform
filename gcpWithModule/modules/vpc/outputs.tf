output "vpc_name" {
  value = google_compute_network.this.name
}

output "vpc_self_link" {
  value = google_compute_network.this.self_link
}
