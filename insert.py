"""
BigQuery Data Insertion Script

Demonstrates inserting and querying records in a BigQuery table
using the google-cloud-bigquery Python client.

Usage:
    export GOOGLE_APPLICATION_CREDENTIALS="/path/to/service-account-key.json"
    python insert.py --project-id your-project-id
"""

import argparse
import sys

from google.cloud import bigquery


def insert_record(
    client: bigquery.Client,
    project_id: str,
    dataset_id: str = "employee_records",
    table_id: str = "employees",
) -> None:
    """Insert a sample record into the BigQuery table."""
    table_ref = f"`{project_id}.{dataset_id}.{table_id}`"

    query = f"""
        INSERT INTO {table_ref} (name, age, registration_id, phone)
        VALUES ('John Doe', 25, '100001', '11999990000')
    """
    job = client.query(query)
    job.result()  # Wait for completion
    print(f"Record inserted into {table_ref}")


def query_records(
    client: bigquery.Client,
    project_id: str,
    dataset_id: str = "employee_records",
    table_id: str = "employees",
) -> None:
    """Query and display all records from the BigQuery table."""
    table_ref = f"`{project_id}.{dataset_id}.{table_id}`"

    query = f"SELECT name, age, registration_id, phone FROM {table_ref}"
    job = client.query(query)

    print("\nQuery results:")
    print("-" * 60)
    for row in job:
        print(
            f"  name={row['name']}, age={row['age']}, "
            f"registration_id={row['registration_id']}, phone={row['phone']}"
        )


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Insert and query records in BigQuery"
    )
    parser.add_argument(
        "--project-id",
        required=True,
        help="GCP project ID",
    )
    parser.add_argument(
        "--dataset-id",
        default="employee_records",
        help="BigQuery dataset ID (default: employee_records)",
    )
    parser.add_argument(
        "--table-id",
        default="employees",
        help="BigQuery table ID (default: employees)",
    )
    args = parser.parse_args()

    client = bigquery.Client(project=args.project_id)

    try:
        insert_record(client, args.project_id, args.dataset_id, args.table_id)
        query_records(client, args.project_id, args.dataset_id, args.table_id)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
