resource "google_bigquery_dataset" "default" {
  dataset_id                  = "table1"
  friendly_name               = "oBoticario"
  description                 = "This is a tecnic test for create a table in bigquery"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }
}

resource "google_bigquery_table" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "teste1"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = "default"
  }

  schema = <<EOF
[
  {
    "name": "Nome",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "Nome do individuo"
  },
  {
    "name": "Idade",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "Idade do individuo"
  },
  {
    "name": "Matricula",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "Numero da matricula do individuo (6 digitos Ex: 999999)"
  },
  {
    "name": "Telefone",
    "type": "STRING",
    "mode": "REQUIRED",
    "description": "Telefone do individuo no formato DDDNumero (Ex: 11999999999)"
  }
]
EOF

}

# resource "google_bigquery_table" "sheet" {
#   dataset_id = google_bigquery_dataset.default.dataset_id
#   table_id   = "sheet"

#   external_data_configuration {
#     autodetect    = true
#     source_format = "GOOGLE_SHEETS"

#     google_sheets_options {
#       skip_leading_rows = 1
#     }

#     source_uris = [
#       "https://docs.google.com/spreadsheets/d/123456789012345",
#     ]
#   }
# }