# S3 bucket module for AWS data lake

# Main S3 bucket resource
resource "aws_s3_bucket" "data_lake_cleaned" {
  bucket = "${var.project_name}-data-lake-${var.uuid}"
}

# Enable versioning for data integrity
resource "aws_s3_bucket_versioning" "data_lake_cleaned_versioning" {
  bucket = aws_s3_bucket.data_lake_cleaned.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "data_lake_cleaned_encryption" {
  bucket = aws_s3_bucket.data_lake_cleaned.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Configure lifecycle rules for data tiering
resource "aws_s3_bucket_lifecycle_configuration" "data_lake_cleaned_lifecycle" {
  bucket = aws_s3_bucket.data_lake_cleaned.id

  rule {
    id     = "archive-old-data"
    status = "Enabled"

    filter {
      prefix = "" # Applies to all objects in the bucket
    }

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "GLACIER_IR"
    }

    noncurrent_version_expiration {
      noncurrent_days = 180
    }
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "data_lake_cleaned_access" {
  bucket = aws_s3_bucket.data_lake_cleaned.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Add bucket policy for cross-account access
resource "aws_s3_bucket_policy" "data_lake_clean_cross_account" {
  bucket = aws_s3_bucket.data_lake_cleaned.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = [
            "arn:aws:iam::${var.account_ids.operations}:root",
            "arn:aws:iam::${var.account_ids.development}:root"
          ]
        }
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.data_lake_cleaned.arn,
          "${aws_s3_bucket.data_lake_cleaned.arn}/*"
        ]
      }
    ]
  })
}

# Create IAM role for cross-account access to clean data lake
resource "aws_iam_role" "data_lake_clean_access_role" {
  name = "${var.project_name}-data-lake-clean-access"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = [
            "arn:aws:iam::${var.account_ids.operations}:root",
            "arn:aws:iam::${var.account_ids.development}:root"
          ]
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Add policy to the role allowing access to the clean data lake
resource "aws_iam_role_policy" "data_lake_clean_access_policy" {
  name = "s3-data-lake-clean-access"
  role = aws_iam_role.data_lake_clean_access_role.id
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.data_lake_cleaned.arn,
          "${aws_s3_bucket.data_lake_cleaned.arn}/*"
        ]
      }
    ]
  })
}
