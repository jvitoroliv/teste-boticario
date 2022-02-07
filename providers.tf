terraform {
  backend "gcs" {
    bucket = "tfstate-968541985189189857418596"
    prefix = "state"
  }
}

# Configura o projeto GCP
provider "google" {
  credentials = file("bigquery-boticario-5d2727435bed.json")
  project     = var.project_id
  region      = var.regiao
}
