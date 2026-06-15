region = "us-central1"
tags = ["web"]
machine_type = "e2-medium"

#Autoscaler variables
min_replicas = 4
max_replicas = 6
cooldown_period = 60
cpu_target_utilization = 0.6
