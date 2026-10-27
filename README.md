# BigQuery Infrastructure — Hiring Assessment

Terraform + Python solution for provisioning a BigQuery dataset and table on Google Cloud Platform, built as a **hiring technical assessment for O Boticário**.

> **Context:** This project was completed as a take-home assessment during the interview process. It demonstrates Infrastructure as Code practices for GCP data platform provisioning.

## Architecture

```
GCP Project
└── BigQuery
    └── Dataset: employee_records
        └── Table: employees (day-partitioned)
            ├── name (STRING, REQUIRED)
            ├── age (INTEGER, REQUIRED)
            ├── registration_id (STRING, REQUIRED)
            └── phone (STRING, REQUIRED)
```

**Components:**
- **Terraform** — Provisions the BigQuery dataset and table with day-based partitioning
- **Python script** — Demonstrates data insertion and querying via the BigQuery client library
- **GCS backend** — Remote state storage for team collaboration

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.3.0
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- Python >= 3.8
- A GCP project with BigQuery API enabled

## Setup

### 1. Authentication

```bash
gcloud auth application-default login
```

### 2. Configure Variables

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your project ID and preferences
```

### 3. Deploy Infrastructure

```bash
terraform init
terraform plan
terraform apply
```

### 4. Insert Sample Data

```bash
pip install -r requirements.txt
python insert.py --project-id your-gcp-project-id
```

## Project Structure

```
.
├── providers.tf              # Provider and backend configuration
├── variables.tf              # Input variable definitions
├── bigquery-table.tf         # BigQuery dataset and table resources
├── outputs.tf                # Output values
├── insert.py                 # Python script for data operations
├── requirements.txt          # Python dependencies
├── terraform.tfvars.example  # Example variable values
└── .gitignore
```

## Design Decisions

| Decision | Rationale |
|---|---|
| Day-based partitioning | Enables efficient time-range queries and cost optimization |
| `deletion_protection = false` | Assessment environment — enable in production |
| Remote GCS backend | Demonstrates state management best practice |
| No hardcoded credentials | Authentication via ADC (Application Default Credentials) |
| Parameterized configuration | All identifiers configurable via variables |

## Security Notes

- Service account keys are excluded via `.gitignore` — authentication uses ADC
- The GCS backend bucket name must be replaced with your own before `terraform init`
- The `terraform.tfvars` file is gitignored to prevent credential leaks

## License

This project was developed as a hiring assessment and is shared for portfolio purposes.
