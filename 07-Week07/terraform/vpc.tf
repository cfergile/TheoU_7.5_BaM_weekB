resource "google_compute_network" "auto-vpc-network" {
  name                    = "auto-vpc-network"
  auto_create_subnetworks = true
}

resource "google_compute_network" "custom-vpc-network" {
  name                    = "custom-vpc-network"
  auto_create_subnetworks = false
}
