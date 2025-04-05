variable "project_name" {
  description = "The name of the project, this is used throughout to rename resources."
  type        = string
}

variable "uuid" {
  description = "A unique identifier for resources."
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

variable "data_lake_clean_bucket_id" {
  description = "ID of the clean data lake bucket to be crawled"
  type        = string
}

variable "data_lake_clean_bucket_arn" {
  description = "ARN of the clean data lake bucket to be crawled"
  type        = string
}

variable "clean_glue_crawler_role_arn" {
  description = "The ARN of the IAM role used by Glue crawlers"
  type        = string
}

variable "processed_glue_crawler_role_arn" {
  description = "The ARN of the IAM role used by Glue crawlers for processed data"
  type        = string
}