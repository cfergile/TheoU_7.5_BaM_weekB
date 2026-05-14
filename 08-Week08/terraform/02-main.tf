resource "google_compute_instance" "vm_instance" {
  name         = "vm-instance"
  machine_type = "n2-standard-2"
  zone         = "us-central1-a"


  tags = ["http-server"]

  labels = {
    source = "local-terraform"
  }

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-stream-10"
      size  = 100
      type  = "pd-standard"
    }
  }


  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP assigned by GCP
    }
  }


  metadata_startup_script = "${path.module}/startup.sh"
}
