output "clean_queue_arn" {
    description = "The ARN of the raw ingest SQS queue"
    value       = aws_sqs_queue.clean_crawler_event_queue.arn
}

output "clean_queue_id" {
    description = "The id of the raw ingest SQS queue"
    value       = aws_sqs_queue.clean_crawler_event_queue.id
}

output "processed_queue_arn" {
    description = "The ARN of the processed SQS queue"
    value       = aws_sqs_queue.processed_crawler_event_queue.arn
}

output "processed_queue_id" {
    description = "The id of the processed SQS queue"
    value       = aws_sqs_queue.processed_crawler_event_queue.id
}