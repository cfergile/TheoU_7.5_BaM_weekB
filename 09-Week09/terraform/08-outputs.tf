output "frontend_ip" {
  description = "The frontend IP address of the Load Balancer"
  value       = google_compute_global_forwarding_rule.web_frontend.ip_address
}


output "frontend_self_link" {
  description = "The self-link URL of the frontend forwarding rule"
  value       = google_compute_global_forwarding_rule.web_frontend.self_link
}