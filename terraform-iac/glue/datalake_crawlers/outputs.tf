output "clean_glue_crawler_role_arn" {
  description = "The ARN of the IAM role used by the clean Glue crawlers"
  value       = aws_iam_role.clean_glue_crawler_role.arn
}

output "clean_glue_crawler_role_name" {
  description = "The name of the IAM role used by the cleanGlue crawlers"
  value       = aws_iam_role.clean_glue_crawler_role.name
}

output "clean_data_lake_crawler_arn" {
  description = "The ARN of the raw data lake crawler"
  value       = aws_glue_crawler.clean_data_lake_crawler.arn
}

output "clean_data_lake_crawler_name" {
  description = "The name of the raw data lake crawler"
  value       = aws_glue_crawler.clean_data_lake_crawler.name
}




output "processed_glue_crawler_role_arn" {
  description = "The ARN of the IAM role used by the clean Glue crawlers"
  value       = aws_iam_role.processed_glue_crawler_role.arn
}

output "processed_glue_crawler_role_name" {
  description = "The name of the IAM role used by the cleanGlue crawlers"
  value       = aws_iam_role.processed_glue_crawler_role.name
}

output "processed_data_lake_crawler_arn" {
  description = "The ARN of the raw data lake crawler"
  value       = aws_glue_crawler.processed_data_lake_crawler.arn
}

output "processed_data_lake_crawler_name" {
  description = "The name of the raw data lake crawler"
  value       = aws_glue_crawler.processed_data_lake_crawler.name
}