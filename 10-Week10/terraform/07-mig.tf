resource "google_compute_region_instance_group_manager" "web" {
  name               = "web"
  region             = var.region
  base_instance_name = "web"
  version {
    instance_template = google_compute_region_instance_template.web.id
  }
  named_port {
    name = "http"
    port = 80
  }
  auto_healing_policies {
    health_check      = google_compute_health_check.web.id
    initial_delay_sec = 120
  }
}