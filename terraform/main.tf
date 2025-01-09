resource "google_project_service" "required_apis" {
  for_each = toset([
    "artifactregistry.googleapis.com",
    "run.googleapis.com",
    "storage.googleapis.com",
    "iamcredentials.googleapis.com",
    "cloudbuild.googleapis.com",
    "logging.googleapis.com",
    "compute.googleapis.com",
  ])
  service = each.value
  disable_on_destroy = false # Prevents Terraform from disabling APIs during resource destruction
}

resource "google_artifact_registry_repository" "langswarm_repo" {
  repository_id         = "langswarm"
  format       = "DOCKER"
  location     = var.region
  description  = "Artifact Registry for LangSwarm backend"
}

terraform {
  backend "gcs" {
    bucket  = "langswarm-terraform"
    prefix  = "terraform/state"
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

resource "google_cloud_run_service" "langswarm_frontend" {
  name     = "langswarm-frontend"
  location = var.region

  template {
    spec {
      containers {
        image = "europe-west1-docker.pkg.dev/${var.project_id}/langswarm/langswarm-frontend:latest"
        ports {
          container_port = 80
        }
        env {
          name  = "REACT_APP_BACKEND_URL"
          value = google_cloud_run_service.langswarm_backend.status[0].url
        }
      }
    }
  }

  autogenerate_revision_name = true
  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [google_cloud_run_service.langswarm_backend]
}
