resource "google_compute_network" "webapp" {
  name                    = "webapp"
  auto_create_subnetworks = false
}