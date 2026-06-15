# Health Check for MIG Autohealing
resource "google_compute_health_check" "web" {
  name                = "web"
  check_interval_sec  = 15
  timeout_sec         = 10
  healthy_threshold   = 2
  unhealthy_threshold = 3

  http_health_check {
    port         = 80
    request_path = "/healthz"
  }
}

# Health Check for Backend Service
resource "google_compute_health_check" "backend" {
  name                = "backend"
  check_interval_sec  = 15
  timeout_sec         = 10
  healthy_threshold   = 2
  unhealthy_threshold = 3

  http_health_check {
    port         = 80
    request_path = "/healthz"
  }
}