resource "google_artifact_registry_repository" "langswarm_repo" {
  name         = "langswarm"
  format       = "DOCKER"
  location     = var.region
  description  = "Artifact Registry for LangSwarm backend"
}

terraform {
  backend "gcs" {
    bucket  = var.backend_enabled ? "your-terraform-state-bucket" : null
    prefix  = "terraform/state"
    project = var.project_id
  }
  # Local backend fallback for testing
  backend "local" {
    enabled = !var.backend_enabled
    path    = "terraform.tfstate"
  }
}

resource "google_cloud_run_service" "langswarm_backend" {
  name     = "langswarm-backend"
  location = var.region

  template {
    spec {
      containers {
        image = "europe-west1-docker.pkg.dev/${var.project_id}/langswarm/langswarm-service:latest"
        ports {
          container_port = 8080
        }
        env {
          name  = "APP_PORT"
          value = "8080"
        }
      }
    }
  }

  autogenerate_revision_name = true
  traffic {
    percent         = 100
    latest_revision = true
  }
}
