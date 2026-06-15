resource "google_compute_health_check" "http_health_check" {
  name = "http-health-check"
  
  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2

  http_health_check {
    port         = 80
    request_path = "/healthz"
  }
}

# Creates a Backend Service for the Load Balancer
resource "google_compute_backend_service" "web_backend" {
  name                  = "web-backend"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL"

  health_checks = [
    google_compute_health_check.http_health_check.id
  ]
# The actual backend- the instance group manager aka managed instance group
  backend {
    group = google_compute_region_instance_group_manager.demo_mig.instance_group
  }
}

# Creates a URL Map to route incoming requests to the backend service
resource "google_compute_url_map" "web_url_map" {
  name            = "web-url-map"
  default_service = google_compute_backend_service.web_backend.id
}

# Serves as HTTP listener for the Load Balancer and forwards requests to the URL Map
resource "google_compute_target_http_proxy" "web_http_proxy" {
  name    = "web-http-proxy"
  url_map = google_compute_url_map.web_url_map.id
}

# Creates a Frontend Service for the Load Balancer, which listens on a public IP and forwards traffic to the target HTTP proxy
resource "google_compute_global_forwarding_rule" "web_frontend" {
  name                  = "web-frontend"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  target                = google_compute_target_http_proxy.web_http_proxy.id
}
