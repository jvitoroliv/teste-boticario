terraform {
  required_version = ">= 1.3.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  # Remote state configuration
  # Replace with your own GCS bucket for state storage
  backend "gcs" {
    bucket = "your-terraform-state-bucket"
    prefix = "bigquery-challenge/state"
  }
}

# GCP provider configuration
# Authentication: set GOOGLE_APPLICATION_CREDENTIALS env var
# or use `gcloud auth application-default login`
provider "google" {
  project = var.project_id
  region  = var.region
}
