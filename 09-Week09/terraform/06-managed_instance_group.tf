# This resource automatically distributes instances across multiple zones in a region; no need to explicitly list zones.
resource "google_compute_region_instance_group_manager" "demo_mig" {
  name               = "demo-mig"
  region             = "us-central1"
  base_instance_name = "demo-instance"
  target_size        = 4

  version {
    instance_template = google_compute_instance_template.mig_template.id
  }

  named_port {
    name = "http"
    port = 80
  }
}

