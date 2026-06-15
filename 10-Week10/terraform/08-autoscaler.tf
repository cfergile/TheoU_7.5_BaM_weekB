resource "google_compute_region_autoscaler" "web" {
  name   = "web"
  region = var.region
  target = google_compute_region_instance_group_manager.web.id

  autoscaling_policy {
    max_replicas    = var.max_replicas
    min_replicas    = var.min_replicas
    cooldown_period = var.cooldown_period

    cpu_utilization {
      target = var.cpu_target_utilization
    }
  }
}