output "extrn_data_bucket_arn" {
  description = "The ARN of the external training data S3 bucket."
  value = aws_s3_bucket.extrn_training_data_bucket.arn
}

output "extrn_data_bucket_id" {
  description = "The ID of the external training data S3 bucket."
  value = aws_s3_bucket.extrn_training_data_bucket.id
}

output "captured_data_bucket_arn" {
  description = "The ARN of the captured training data S3 bucket."
  value = aws_s3_bucket.captured_training_data_bucket.arn

}

output "captured_data_bucket_id" {
  description = "The ID of the captured training data S3 bucket."
  value = aws_s3_bucket.captured_training_data_bucket.id
}

output "data_lake_clean_bucket_name" {
  description = "The name of the cleaned data lake S3 bucket."
  value = aws_s3_bucket.data_lake_cleaned.bucket
}

output "data_lake_clean_bucket_arn" {
  description = "The ARN of the cleaned data lake S3 bucket."
  value = aws_s3_bucket.data_lake_cleaned.arn
}

output "data_lake_clean_bucket_id" {
  description = "The ID of the cleaned data lake S3 bucket."
  value = aws_s3_bucket.data_lake_cleaned.id
}

output "data_lake_processed_bucket_name" {
  description = "The name of the processed data lake S3 bucket."
  value = aws_s3_bucket.data_lake_processed_bucket.bucket
}

output "data_lake_processed_bucket_arn" {
  description = "The ARN of the processed data lake S3 bucket."
  value = aws_s3_bucket.data_lake_processed_bucket.arn
}

output "data_lake_processed_bucket_id" {
  description = "The ID of the processed data lake S3 bucket."
  value = aws_s3_bucket.data_lake_processed_bucket.id
}
