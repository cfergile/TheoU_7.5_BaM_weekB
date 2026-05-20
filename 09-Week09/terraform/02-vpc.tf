resource "google_compute_network" "custom_vpc_network" {
  name                    = "custom-vpc-network"
  auto_create_subnetworks = false
}



