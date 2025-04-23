# Data Organization

This module manages the data infrastructure for the ASL Dataset project, including:

- Data lake configuration
- ETL processes
- Data access policies
- Cross-account data sharing

## Components

- `main.tf` - Core data infrastructure setup
- `outputs.tf` - Exported resource identifiers
- `terraform-iac/` - Additional infrastructure components:
  - `glue/` - AWS Glue configuration for ETL processes
  - `s3/` - Data storage buckets and policies

## Usage

Deploy this module to set up the data storage and processing infrastructure.

```bash
terraform init
terraform plan
terraform apply
```

## Outputs

The module exports data bucket names, role ARNs, and other identifiers needed by the application and ML pipelines to access the data infrastructure.