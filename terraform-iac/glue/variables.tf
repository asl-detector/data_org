variable "project_name" {
  description = "The name of the project, this is used throughout to rename resources."
  type        = string
}

variable "uuid" {
  description = "A unique identifier that will be appended to bucket names."
  type        = string
  default     = "asl-dataset-00"
}

variable "data_lake_processed_bucket_name" {
  description = "Name of the cleaned data lake bucket to be crawled"
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

variable "data_lake_clean_bucket_name" {
  description = "Name of the cleaned data lake bucket to be crawled"
  type        = string
}

variable "data_lake_clean_bucket_id" {
  description = "ID of the cleaned data lake bucket to be crawled"
  type        = string
}

variable "data_lake_clean_bucket_arn" {
  description = "ARN of the cleaned data lake bucket to be crawled"
  type        = string
}