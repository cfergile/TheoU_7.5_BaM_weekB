output "network" {
    value = google_compute_network.webapp.name
}

output "instance_group_manager_name" {
  value = google_compute_region_instance_group_manager.web.name
}

output "load_balancer_ip" {
  value = "http://${google_compute_global_address.web.address}"

}
