variable "project_id" {
  description = "GCP project ID where BigQuery resources will be created"
  type        = string
}

variable "region" {
  description = "GCP region for resource deployment"
  type        = string
  default     = "northamerica-northeast1"
}

variable "dataset_id" {
  description = "BigQuery dataset identifier"
  type        = string
  default     = "employee_records"
}

variable "table_id" {
  description = "BigQuery table identifier"
  type        = string
  default     = "employees"
}

variable "table_expiration_ms" {
  description = "Default table expiration in milliseconds (0 = no expiration)"
  type        = number
  default     = 3600000
}

variable "environment" {
  description = "Environment label (e.g., dev, staging, production)"
  type        = string
  default     = "dev"
}
