# Remote state access for AWS organization structure
data "terraform_remote_state" "org_structure" {
  backend = "s3"
  config = {
    bucket = "terraform-state-asl-foundation"
    key    = "organization/terraform.tfstate"
    region = "us-west-2"
  }
}

locals {
  account_ids = data.terraform_remote_state.org_structure.outputs.account_ids
}

module "s3" {
  source       = "./terraform-iac/s3"
  project_name = var.project_name
  uuid         = var.uuid
  
  # Pass account IDs from organization structure
  account_ids = local.account_ids
}

module "glue" {
  source       = "./terraform-iac/glue"
  project_name = var.project_name
  uuid         = var.uuid

  data_lake_processed_bucket_name = module.s3.data_lake_processed_bucket_name
  data_lake_processed_bucket_id = module.s3.data_lake_processed_bucket_id
  data_lake_processed_bucket_arn = module.s3.data_lake_processed_bucket_arn
  data_lake_clean_bucket_name = module.s3.data_lake_clean_bucket_name
  data_lake_clean_bucket_id = module.s3.data_lake_clean_bucket_id
  data_lake_clean_bucket_arn = module.s3.data_lake_clean_bucket_arn
}