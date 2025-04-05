# IAM role for the Glue crawler
resource "aws_iam_role" "processed_glue_crawler_role" {
  name = "${var.project_name}-processed-glue-crawler-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "glue.amazonaws.com"
      },
      Effect = "Allow",
      Sid    = ""
    }]
  })
}

# Attach AWS managed policy for Glue service
resource "aws_iam_role_policy_attachment" "processed_glue_service_role" {
  role       = aws_iam_role.processed_glue_crawler_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

# Custom policy for S3 access
resource "aws_iam_policy" "processed_glue_crawler_s3_access" {
  name        = "${var.project_name}-processed-glue-crawler-s3-policy"
  description = "Policy for Glue crawler to access S3 buckets"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          var.data_lake_processed_bucket_arn,
          "${var.data_lake_processed_bucket_arn}/*"
        ]
      }
    ]
  })
}

# Attach custom S3 policy to the role
resource "aws_iam_role_policy_attachment" "processed_glue_crawler_s3" {
  role       = aws_iam_role.processed_glue_crawler_role.name
  policy_arn = aws_iam_policy.processed_glue_crawler_s3_access.arn
}

# Add SQS permission to Glue role
resource "aws_iam_policy" "processed_glue_crawler_sqs_access" {
  name        = "${var.project_name}-processed-glue-crawler-sqs-policy"
  description = "Policy for Glue crawler to access SQS"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueUrl",
          "sqs:GetQueueAttributes",
          "sqs:ListQueueTags",
          "sqs:ListDeadLetterSourceQueues",                
          "sqs:PurgeQueue",
          "sqs:SetQueueAttributes"
        ],
        Resource = [
          var.processed_queue_arn
        ]
      }
    ]
  })
}

# Attach SQS policy to the Glue role
resource "aws_iam_role_policy_attachment" "processed_glue_crawler_sqs" {
  role       = aws_iam_role.processed_glue_crawler_role.name
  policy_arn = aws_iam_policy.processed_glue_crawler_sqs_access.arn
}


# Define the Glue crawler for the data lake bucket
resource "aws_glue_crawler" "processed_data_lake_crawler" {
  name          = "${var.project_name}-processed-data-lake-crawler"
  role          = aws_iam_role.processed_glue_crawler_role.arn
  database_name = var.database_name
  
  s3_target {
    path = "s3://${var.data_lake_processed_bucket_name}/"
    exclusions = [
      "*.temp*",
      "**/_temporary/**",
      "**/.tmp/**"
    ]
    # Configure SQS-based event trigger
    event_queue_arn = var.processed_queue_arn
  }
  
  # Only crawl newly notified paths
  recrawl_policy {
    recrawl_behavior = "CRAWL_EVENT_MODE"
  }

  # Configuration settings
  configuration = jsonencode({
    Version = 1.0,
    CrawlerOutput = {
      Partitions = { AddOrUpdateBehavior = "InheritFromTable" },
      Tables = { AddOrUpdateBehavior = "MergeNewColumns" }
    },
    CreatePartitionIndex = true,
  })

  # Advanced options
  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "UPDATE_IN_DATABASE"
  }
  
  # Classify files automatically
  classifiers = []
  table_prefix = "processed_"
  
  # Wait for IAM role propagation
  depends_on = [
    aws_iam_role_policy_attachment.processed_glue_crawler_s3,
    aws_iam_role_policy_attachment.processed_glue_service_role,
    aws_iam_role_policy_attachment.processed_glue_crawler_sqs
  ]
}