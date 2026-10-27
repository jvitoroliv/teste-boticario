# -----------------------------------------------------------------------------
# BigQuery Dataset
# Creates a dataset to organize and control access to tables
# -----------------------------------------------------------------------------
resource "google_bigquery_dataset" "default" {
  dataset_id                  = var.dataset_id
  friendly_name               = "Employee Records"
  description                 = "Dataset for storing employee record data as part of a BigQuery technical assessment"
  location                    = var.region
  default_table_expiration_ms = var.table_expiration_ms

  labels = {
    env     = var.environment
    managed = "terraform"
  }
}

# -----------------------------------------------------------------------------
# BigQuery Table
# Partitioned table for employee records with typed schema
# -----------------------------------------------------------------------------
resource "google_bigquery_table" "default" {
  dataset_id          = google_bigquery_dataset.default.dataset_id
  table_id            = var.table_id
  deletion_protection = false

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env     = var.environment
    managed = "terraform"
  }

  schema = <<EOF
[
  {
    "name": "name",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "Full name of the individual"
  },
  {
    "name": "age",
    "type": "INTEGER",
    "mode": "REQUIRED",
    "description": "Age of the individual"
  },
  {
    "name": "registration_id",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "Registration number (6 digits, e.g., 999999)"
  },
  {
    "name": "phone",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "Phone number in format area_code + number (e.g., 11999999999)"
  }
]
EOF
}

# -----------------------------------------------------------------------------
# (Optional) Google Sheets External Table
# Uncomment to create a BigQuery table backed by a Google Sheets source
# -----------------------------------------------------------------------------
# resource "google_bigquery_table" "sheet" {
#   dataset_id = google_bigquery_dataset.default.dataset_id
#   table_id   = "sheet"
#
#   external_data_configuration {
#     autodetect    = true
#     source_format = "GOOGLE_SHEETS"
#
#     google_sheets_options {
#       skip_leading_rows = 1
#     }
#
#     source_uris = [
#       "https://docs.google.com/spreadsheets/d/YOUR_SHEET_ID",
#     ]
#   }
# }
