output "extrn_data_bucket_arn" {
  value = aws_s3_bucket.extrn_training_data_bucket.arn
}

output "extrn_data_bucket_id" {
  value = aws_s3_bucket.extrn_training_data_bucket.id
}

output "captured_data_bucket_arn" {
  value = aws_s3_bucket.captured_training_data_bucket.arn

}

output "captured_data_bucket_id" {
  value = aws_s3_bucket.captured_training_data_bucket.id
}

output "data_lake_clean_bucket_arn" {
  value = aws_s3_bucket.data_lake_cleaned.arn
}

output "data_lake_clean_bucket_id" {
  value = aws_s3_bucket.data_lake_cleaned.id
}

output "data_lake_processed_bucket_arn" {
  value = aws_s3_bucket.data_lake_processed_bucket.arn
}

output "data_lake_processed_bucket_id" {
  value = aws_s3_bucket.data_lake_processed_bucket.id
}
