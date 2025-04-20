output "data_lake_processed_bucket_name" {
  description = "The name of the processed data lake S3 bucket."
  value = module.s3.data_lake_processed_bucket_name
}

output "data_lake_processed_bucket_arn" {
  description = "The ARN of the processed data lake S3 bucket."
  value = module.s3.data_lake_processed_bucket_arn
}

output "data_lake_processed_bucket_id" {
  description = "The ID of the processed data lake S3 bucket."
  value = module.s3.data_lake_processed_bucket_id
}

output "data_lake_processed_access_role_arn" {
  description = "The ARN of the role for cross-account access to the processed data lake bucket."
  value = module.s3.data_lake_processed_access_role_arn
}

output "data_lake_clean_bucket_name" {
  description = "The name of the cleaned data lake S3 bucket."
  value = module.s3.data_lake_clean_bucket_name
}

output "data_lake_clean_bucket_arn" {
  description = "The ARN of the cleaned data lake S3 bucket."
  value = module.s3.data_lake_clean_bucket_arn
}

output "data_lake_clean_bucket_id" {
  description = "The ID of the cleaned data lake S3 bucket."
  value = module.s3.data_lake_clean_bucket_id
}

output "data_lake_clean_access_role_arn" {
  description = "The ARN of the role for cross-account access to the clean data lake bucket."
  value = module.s3.data_lake_clean_access_role_arn
}

output "captured_data_bucket_name" {
  description = "The name of the captured training data S3 bucket."
  value = module.s3.captured_data_bucket_name
}

output "captured_data_bucket_arn" {
  description = "The ARN of the captured training data S3 bucket."
  value = module.s3.captured_data_bucket_arn
}

output "captured_data_bucket_id" {
  description = "The ID of the captured training data S3 bucket."
  value = module.s3.captured_data_bucket_id
}

output "captured_data_access_role_arn" {
  description = "The ARN of the role for cross-account access to the captured dataset bucket."
  value = module.s3.captured_data_access_role_arn
}

output "extrn_data_bucket_arn" {
  description = "The ARN of the external training data S3 bucket."
  value = module.s3.extrn_data_bucket_arn
}

output "extrn_data_bucket_id" {
  description = "The ID of the external training data S3 bucket."
  value = module.s3.extrn_data_bucket_id
}

output "extrn_data_access_role_arn" {
  description = "The ARN of the role for cross-account access to the external training data bucket."
  value = module.s3.extrn_data_access_role_arn
}