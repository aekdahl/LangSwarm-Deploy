module "langswarm_backend" {
  source  = "./backend"
  project_id = var.project_id
  region     = var.region
}

module "langswarm_frontend" {
  source  = "./frontend"
  project_id = var.project_id
  region     = var.region
}
