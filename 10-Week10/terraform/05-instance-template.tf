resource "google_compute_region_instance_template" "web" {
  name         = "web"
  machine_type = var.machine_type
  tags         = var.tags

  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
    boot         = true
  }
  network_interface {
    subnetwork = google_compute_subnetwork.web.id
    access_config {

    }
  }
  metadata_startup_script = file("./startup.sh")
}