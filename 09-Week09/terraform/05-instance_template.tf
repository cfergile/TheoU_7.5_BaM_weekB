resource "google_compute_instance_template" "mig_template" {
  name = "mig-template"
  machine_type = "e2-medium"

  tags = ["web-server"]

  network_interface {
    network = google_compute_network.custom_vpc_network.id
    subnetwork = google_compute_subnetwork.custom_subnet.id
    access_config {
      // Ephemeral public IP
    }
  }

  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete = true
    boot = true
  }

  metadata_startup_script = file("${path.module}/startup.sh")

}
