# External Global Application Load Balancer with a Managed Instance Group using Terraform

## Project Overview

This project documents and implements an external global Application Load Balancer on Google Cloud Platform using both Google Cloud Console ClickOps and Terraform.

For the manual Google Cloud Console deployment walkthrough, refer to:

`documentation/runbook.md`

The goal of this project is to first understand the infrastructure through a manual Google Cloud Console deployment, then translate that same architecture into repeatable Infrastructure as Code with Terraform.

---

# Architecture

```text
Internet
    ↓
Global Forwarding Rule (Frontend)
    ↓
Target HTTP Proxy
    ↓
URL Map
    ↓
Backend Service
    ↓
Managed Instance Group (MIG)
    ↓
VM Instances
```

---

# Terraform Resources Used

| File                   | Terraform Resource                             | Documentation                                                                                                                                                                                                                                |
| ---------------------- | ---------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `vpc.tf`               | `google_compute_network`                       | [https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network)                                             |
| `subnets.tf`           | `google_compute_subnetwork`                    | [https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork)                                       |
| `firewall.tf`          | `google_compute_firewall`                      | [https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)                                           |
| `instance-template.tf` | `google_compute_instance_template`             | [https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_template](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_template)                         |
| `managed-instance.tf`  | `google_compute_region_instance_group_manager` | [https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_instance_group_manager](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_instance_group_manager) |
| `load_balancer.tf`     | `google_compute_health_check`                  | [https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_health_check](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_health_check)                                   |
| `load_balancer.tf`     | `google_compute_backend_service`               | [https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_service](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_service)                             |
| `load_balancer.tf`     | `google_compute_url_map`                       | [https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map)                                             |
| `load_balancer.tf`     | `google_compute_target_http_proxy`             | [https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_http_proxy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_http_proxy)                         |
| `load_balancer.tf`     | `google_compute_global_forwarding_rule`        | [https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule)               |
| `outputs.tf`           | Terraform Outputs                              | [https://developer.hashicorp.com/terraform/language/values/outputs](https://developer.hashicorp.com/terraform/language/values/outputs)                                                                                                       |

---

# Infrastructure Components

* Custom VPC
* Custom subnet
* Firewall rules using target tags
* Instance template with startup script
* Regional Managed Instance Group (MIG)
* External HTTP Application Load Balancer
* Health checks
* Frontend forwarding rules
* Terraform outputs for the load balancer frontend IP

---

# Load Balancer Components

* Health check
* Backend service
* URL map
* Target HTTP proxy
* Global forwarding rule

---

# Outputs

The project outputs:

* Frontend public IP address
* Forwarding rule self-link

Example:

```bash
terraform output frontend_ip
```

---

# Testing

After deployment:

1. Retrieve the frontend IP:

```bash
terraform output frontend_ip
```

2. Open the IP in a browser:

```text
http://<frontend_ip>
```

3. Refresh the page to observe traffic being served by different backend instances.

---

## Challenges and Takeaways

One of the biggest challenges during this project was translating what I was doing in the Google Cloud Console into actual Terraform resources. While the console simplifies much of the infrastructure setup behind the scenes, Terraform required me to explicitly define and understand each individual component involved in the load balancer architecture.

Once I started recreating the same architecture with Terraform, I realized there were several components I had not initially considered, such as the URL map and target HTTP proxy. Having to explicitly define each resource forced me to develop a more granular understanding of how traffic flows through the load balancer and how the various backend and frontend components interact.

Overall, the Terraform implementation gave me a much deeper appreciation and understanding of the infrastructure being built behind the scenes in the Google Cloud Console.