# Add SQS Queue for S3 event notifications
resource "aws_sqs_queue" "clean_crawler_event_queue" {
  name = "${var.project_name}-clean-crawler-events-${var.uuid}"

  visibility_timeout_seconds = 900   # 15 minutes, longer than crawler runtime
  message_retention_seconds  = 86400 # 1 day
}

# Policy to allow S3 to send messages to SQS
resource "aws_sqs_queue_policy" "clean_crawler_queue_policy" {
  queue_url = aws_sqs_queue.clean_crawler_event_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "s3.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.clean_crawler_event_queue.arn
        Condition = {
          ArnLike = {
            "aws:SourceArn" = [
              var.data_lake_clean_bucket_arn,
            ]
          }
        }
      },
    ]
  })
}

# Resource: Configure S3 bucket notification to send events to SQS
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.data_lake_clean_bucket_id

  queue {
    queue_arn     = aws_sqs_queue.clean_crawler_event_queue.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".csv"
  }

  queue {
    queue_arn     = aws_sqs_queue.clean_crawler_event_queue.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".json"
  }

  queue {
    queue_arn     = aws_sqs_queue.clean_crawler_event_queue.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".parquet"
  }
}
