resource "google_project_service" "required_apis" {
  for_each = toset([
    "artifactregistry.googleapis.com",
    "run.googleapis.com",
    "storage.googleapis.com",
    # "iamcredentials.googleapis.com",
    "cloudbuild.googleapis.com",
    "logging.googleapis.com",
    "compute.googleapis.com",
  ])
  service = each.value
  disable_on_destroy = false # Prevents Terraform from disabling APIs during resource destruction
}

resource "google_artifact_registry_repository" "langswarm_repo" {
  repository_id    = "langswarm"
  format           = "DOCKER"
  location         = var.region
  description      = "Artifact Registry for LangSwarm backend"
}

terraform {
  backend "gcs" {
    bucket  = "langswarm-terraform"
    prefix  = "terraform/state"
  }
}
