output "internal_ip" {
  description = "The internal (private) IP of the VM"
  value       = google_compute_instance.vm_instance.network_interface[0].network_ip
}

output "external_ip" {
  description = "The external (public) IP of the VM"
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

output "instance_name" {
  description = "The name of the VM instance"
  value       = google_compute_instance.vm_instance.name
}

output "instance_id" {
  description = "The unique identifier of the VM instance"
  value       = google_compute_instance.vm_instance.id
}

output "instance_self_link" {
  description = "The self-link URL of the VM instance"
  value       = google_compute_instance.vm_instance.self_link
}
