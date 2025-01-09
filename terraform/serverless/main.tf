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
        image = "europe-west1-docker.pkg.dev/${var.project_id}/langswarm/langswarm-backend:latest"
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
