# SQS Queue for processed data lake events
#
resource "aws_sqs_queue" "processed_crawler_event_queue" {
  name = "${var.project_name}-processed-crawler-events-${var.uuid}"

  visibility_timeout_seconds = 900   # 15 minutes
  message_retention_seconds  = 86400 # 1 day
}

# Policy to allow S3 to send messages to the processed SQS queue
resource "aws_sqs_queue_policy" "processed_crawler_queue_policy" {
  queue_url = aws_sqs_queue.processed_crawler_event_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "s3.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.processed_crawler_event_queue.arn
        Condition = {
          ArnLike = {
            "aws:SourceArn" = var.data_lake_processed_bucket_arn
          }
        }
      },
    #   {
    #     Effect = "Allow",
    #     Principal = {
    #       AWS = var.glue_crawler_role_arn
    #     },
    #     Action = [
    #       "sqs:ReceiveMessage",
    #       "sqs:DeleteMessage",
    #       "sqs:GetQueueUrl",
    #       "sqs:GetQueueAttributes",
    #       "sqs:ListDeadLetterSourceQueues",
    #       "sqs:PurgeQueue",
    #       "sqs:SetQueueAttributes"
    #     ],
    #     Resource = aws_sqs_queue.processed_crawler_event_queue.arn
    #   }
    ]
  })
}

# Notification configuration for processed bucket
resource "aws_s3_bucket_notification" "processed_bucket_notification" {
  bucket = var.data_lake_processed_bucket_id

  queue {
    queue_arn     = aws_sqs_queue.processed_crawler_event_queue.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".csv"
  }

  queue {
    queue_arn     = aws_sqs_queue.processed_crawler_event_queue.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".json"
  }

  queue {
    queue_arn     = aws_sqs_queue.processed_crawler_event_queue.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".parquet"
  }

}
