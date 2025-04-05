output "glue_database_name" {
  description = "The name of the Glue database created."
  value       = aws_glue_catalog_database.glue_database.name
}

output "glue_database_arn" {
  description = "The ARN of the Glue database created."
  value       = aws_glue_catalog_database.glue_database.arn
}

output "glue_database_id" {
  description = "The ID of the Glue database created."
  value       = aws_glue_catalog_database.glue_database.id
}