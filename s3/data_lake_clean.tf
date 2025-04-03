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
resource "aws_s3_bucket_public_access_block" "data_lake_cleaned_access" {
    bucket = aws_s3_bucket.data_lake_cleaned.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}