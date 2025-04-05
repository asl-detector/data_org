module "s3" {
  source       = "./terraform-iac/s3"
  project_name = var.project_name
  uuid         = var.uuid
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