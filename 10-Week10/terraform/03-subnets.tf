resource "google_compute_subnetwork" "web" {
  name          = "web"
  network       = google_compute_network.webapp.id
  ip_cidr_range = "192.168.16.0/24"
}