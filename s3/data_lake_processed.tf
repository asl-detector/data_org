# S3 bucket module for AWS data lake after processing

# Main S3 bucket resource
resource "aws_s3_bucket" "data_lake_processed_bucket" {
    bucket = "${var.project_name}-data-lake-processed-${var.uuid}"
}

# Enable versioning for data integrity
resource "aws_s3_bucket_versioning" "data_lake_processed_bucket_versioning" {
    bucket = aws_s3_bucket.data_lake_processed_bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}

# Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "data_lake_processed_bucket_encryption" {
    bucket = aws_s3_bucket.data_lake_processed_bucket.id

    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

# Configure lifecycle rules for data tiering
resource "aws_s3_bucket_lifecycle_configuration" "data_lake_processed_bucket_lifecycle" {
    bucket = aws_s3_bucket.data_lake_processed_bucket.id

    rule {
        id     = "archive-old-data"
        status = "Enabled"

        noncurrent_version_transition {
            noncurrent_days = 30
            storage_class = "GLACIER_IR"
        }

        noncurrent_version_expiration {
            noncurrent_days = 180
        }
    }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "data_lake_processed_bucket_access" {
    bucket = aws_s3_bucket.data_lake_processed_bucket.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}