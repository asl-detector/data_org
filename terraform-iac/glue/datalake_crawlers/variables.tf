variable "project_name" {
  description = "The name of the project, this is used throughout to rename resources."
  type        = string
}

variable "uuid" {
  description = "A unique identifier for resources."
  type        = string
}

variable "database_name" {
  description = "The name of the Glue catalog database where tables will be created."
  type        = string
}

variable "data_lake_clean_bucket_id" {
  description = "ID of the cleaned data lake bucket to be crawled"
  type        = string
}

variable "data_lake_clean_bucket_name" {
  description = "name of the cleaned data lake bucket to be crawled"
  type        = string
}

variable "data_lake_clean_bucket_arn" {
  description = "ARN of the cleaned data lake bucket to be crawled"
  type        = string
}

variable "data_lake_processed_bucket_name" {
  description = "name of the processed data lake bucket to be crawled"
  type        = string
}

variable "data_lake_processed_bucket_id" {
  description = "ID of the processed data lake bucket to be crawled"
  type        = string
}

variable "data_lake_processed_bucket_arn" {
  description = "ARN of the processed data lake bucket to be crawled"
  type        = string
}

variable "processed_queue_arn" {
  description = "ARN of the SQS queue for the crawler to use for update notifications"
  type        = string  
}

variable "clean_queue_arn" {
  description = "ARN of the SQS queue for the crawler to use for update notifications"
  type        = string  
}


