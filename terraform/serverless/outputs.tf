output "backend_url" {
  value = google_cloud_run_service.langswarm_backend.status[0].url
}

output "frontend_url" {
  value = google_cloud_run_service.langswarm_frontend.status[0].url
}
