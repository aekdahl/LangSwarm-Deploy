module "langswarm_backend" {
  source  = "./"
  project_id = var.project_id
  region     = var.region
}

module "langswarm_frontend" {
  source  = "./"
  project_id = var.project_id
  region     = var.region
}
