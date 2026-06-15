resource "google_compute_backend_service" "web" {
  name                  = "web"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  protocol              = "HTTP"
  port_name             = "http"
  timeout_sec           = 10
  health_checks         = [google_compute_health_check.backend.id]

  backend {
    group = google_compute_region_instance_group_manager.web.instance_group
  }
}

