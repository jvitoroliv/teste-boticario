# -----------------------------------------------------------------------------
# Outputs
# Expose key resource attributes for downstream consumption
# -----------------------------------------------------------------------------

output "dataset_id" {
  description = "The ID of the created BigQuery dataset"
  value       = google_bigquery_dataset.default.dataset_id
}

output "table_id" {
  description = "The ID of the created BigQuery table"
  value       = google_bigquery_table.default.table_id
}

output "dataset_self_link" {
  description = "Self link of the BigQuery dataset"
  value       = google_bigquery_dataset.default.self_link
}

output "table_self_link" {
  description = "Self link of the BigQuery table"
  value       = google_bigquery_table.default.self_link
}
