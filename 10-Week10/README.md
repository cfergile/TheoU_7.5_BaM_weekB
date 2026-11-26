# Week 10: Autoscaling Web Tier in Terraform + Network Troubleshooting

This week has two projects on Google Cloud:

1. **[Autoscaling, self-healing web tier in Terraform](#1-autoscaling-self-healing-web-tier-terraform)**: a global HTTP load balancer in front of a regional managed instance group that scales on CPU and replaces unhealthy instances. Code is in [`terraform/`](terraform).
2. **[Troubleshooting a broken web server](#2-troubleshooting-a-broken-web-server-six-root-causes)**: a layer-by-layer investigation that found six stacked faults. The full log is in [`documentation/runbook.md`](documentation/runbook.md).

---

## 1. Autoscaling, self-healing web tier (Terraform)

### Architecture

```text
Internet
   │
   ▼
Global forwarding rule  (reserved global IP, port 80)
   │
   ▼
Target HTTP proxy  →  URL map
   │
   ▼
Backend service  ──  health check  GET /healthz :80
   │
   ▼
Regional managed instance group  (us-central1, spread across zones)
   ├─ autohealing: recreate instances that fail /healthz (120 s initial delay)
   └─ autoscaler: 4–6 instances, target 60% CPU, 60 s cooldown
        │
        ▼
     nginx web servers  (custom VPC "webapp", subnet 192.168.16.0/24, HTTP allowed by tag)
```

### What I built

| File | Resource |
|---|---|
| `02-vpc.tf`, `03-subnets.tf` | Custom VPC and subnet |
| `04-firewall.tf` | Tag-scoped firewall rule allowing HTTP |
| `05-instance-template.tf`, `startup.sh` | Regional instance template; startup script installs nginx and serves an instance-identity page and a `/healthz` endpoint |
| `06-healthcheck.tf` | Separate health checks for autohealing and for the load balancer backend |
| `07-mig.tf` | Regional managed instance group with a named port and autohealing policy |
| `08-autoscaler.tf` | Regional autoscaler: min 4, max 6, CPU target 60%, cooldown 60 s |
| `09-backend.tf`, `10-frontend.tf` | Backend service, URL map, target HTTP proxy, reserved global IP and forwarding rule |
| `00-variables.tf`, `terraform.tfvars` | Region, machine type, tags and every autoscaler setting as variables |
| `11-outputs.tf` | Network, instance group name and load balancer IP |

### Run it

```bash
cd terraform
terraform init
terraform plan
terraform apply
# open the load_balancer_ip output; refresh to see different instances respond
terraform destroy
```

> The startup script is adapted from course-provided material.

---

## 2. Troubleshooting a broken web server: six root causes

A Compute Engine VM was supposed to serve a public web page and accept SSH, and did neither. I worked the problem one layer at a time, re-testing after every change, and found **six independent faults** stacked on top of each other.

**Order of investigation:** VM state → firewall rules → source ranges → external IP → network tags → application (Apache) → connectivity from inside the VM → VPC routes

| # | Fault | Why it broke things | Fix |
|---|---|---|---|
| 1 | VM was stopped | A stopped VM serves nothing | Started the instance |
| 2 | Firewall priorities inverted | A `deny-all` rule had a lower number (higher priority) than the allow rules, so it always won | Re-ordered priorities so the SSH/HTTP allow rules evaluate first |
| 3 | SSH rule allowed only `1.2.3.4/32` | The allow rule never matched real clients | Widened the source range to confirm the cause (tested with `0.0.0.0/0`) |
| 4 | No external IP | Nothing on the internet could reach the VM | Assigned an external IPv4 address |
| 5 | Missing network tag | The HTTP allow rule targets a tag the VM didn't have | Added the tag to the VM |
| 6 | No default route (`0.0.0.0/0`) in the custom VPC | The only default route belonged to the `default` VPC, so this VPC had no path to the internet | Created a default route to the internet gateway |

The last fault was the hardest to spot. Apache was running and `curl localhost` worked, yet `ping 8.8.8.8` showed 100% packet loss and HTTP timed out. Checking **VPC → Routes** showed only the local subnet route for this network.

**Validation:** `ping 8.8.8.8` succeeded after the route fix, the page loaded in a browser through the external IP, and `curl` on the VM returned the expected response.

![HTTP restored](images/http-confirmation.png)

**Takeaway:** outages often have more than one cause. Stopping after the first fix would have left the server broken; testing each layer independently surfaced all six.

---

**Tech:** Terraform · Compute Engine · instance templates · regional managed instance groups · autoscaler · health checks · global external HTTP load balancer · VPC · firewall rules & priorities · network tags · routes · nginx · Apache · Linux networking tools (`ss`, `curl`, `ping`)
