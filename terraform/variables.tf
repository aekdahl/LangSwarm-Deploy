variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region for deployment"
  type        = string
  default     = "europe-west1"
}

variable "service_account_email" {
  description = "Service account email for deployments"
  type        = string
}

variable "backend_enabled" {
  description = "Enable remote backend (true for production, false for local state)"
  type        = bool
  default     = false
}
