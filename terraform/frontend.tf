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
}
