output "auto" {
  value = google_compute_network.auto-vpc-network.id
}

output "custom" {
  value = google_compute_network.custom-vpc-network.id
}