variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "backend_enabled" {
  description = "Enable remote backend (true for production, false for local state)"
  type        = bool
  default     = false
}

