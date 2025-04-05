module "database" {
  source       = "./database"
  project_name = var.project_name
}

module "datalake_crawlers" {
  source      = "./datalake_crawlers"
    project_name = var.project_name
    uuid         = var.uuid


    database_name = module.database.glue_database_name

    data_lake_processed_bucket_name = var.data_lake_processed_bucket_name
    data_lake_processed_bucket_arn = var.data_lake_processed_bucket_arn
    data_lake_processed_bucket_id = var.data_lake_processed_bucket_id
    data_lake_clean_bucket_name = var.data_lake_clean_bucket_name
    data_lake_clean_bucket_arn = var.data_lake_clean_bucket_arn
    data_lake_clean_bucket_id = var.data_lake_clean_bucket_id


    processed_queue_arn = module.sqs.processed_queue_arn
    clean_queue_arn = module.sqs.clean_queue_arn
}

module "sqs" {
  source       = "./sqs"
    project_name = var.project_name
    uuid         = var.uuid

  data_lake_clean_bucket_arn = var.data_lake_clean_bucket_arn
    data_lake_clean_bucket_id  = var.data_lake_clean_bucket_id
    data_lake_processed_bucket_arn = var.data_lake_processed_bucket_arn
    data_lake_processed_bucket_id  = var.data_lake_processed_bucket_id
    clean_glue_crawler_role_arn = module.datalake_crawlers.clean_glue_crawler_role_arn

}

