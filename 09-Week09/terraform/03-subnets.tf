resource "google_compute_subnetwork" "custom_subnet" {
  name          = "custom-subnet"
  ip_cidr_range = "10.128.0.0/20"
    region        = "us-central1"
    network       = google_compute_network.custom_vpc_network.id
}