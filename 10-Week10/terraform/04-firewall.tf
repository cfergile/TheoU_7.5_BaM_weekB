resource "google_compute_firewall" "http_allow" {
  name    = "http-allow"
  network = google_compute_network.webapp.id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]

  target_tags = var.tags
}