variable "region" {
  description = "The region to host resources in"
  type        = string
  default     = "us-central1"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = list(string)
  default     = ["web"]
}

variable "machine_type" {
  description = "The machine type to use for instances"
  type        = string
  default     = "e2-medium"
}

variable "min_replicas" {
  description = "Minimum number of instances in the MIG"
  type        = number
  default     = 4
}

variable "max_replicas" {
  description = "Maximum number of instances in the MIG"
  type        = number
  default     = 6
}

variable "cooldown_period" {
  description = "Cooldown period for autoscaling in seconds"
  type        = number
  default     = 60
}

variable "cpu_target_utilization" {
  description = "Target CPU utilization for autoscaling"
  type        = number
  default     = 0.6
}