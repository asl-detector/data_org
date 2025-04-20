resource "aws_s3_bucket" "captured_training_data_bucket" {
  bucket        = "${var.project_name}-captured-raw-training-${var.uuid}"
  force_destroy = false
}

resource "aws_s3_bucket_server_side_encryption_configuration" "captured_training_data_bucket_encryption" {
  bucket = aws_s3_bucket.captured_training_data_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "captured_training_data_bucket_public_access" {
  bucket = aws_s3_bucket.captured_training_data_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Add bucket policy for cross-account access from backend accounts
resource "aws_s3_bucket_policy" "captured_training_data_cross_account" {
  bucket = aws_s3_bucket.captured_training_data_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = [
            "arn:aws:iam::${var.account_ids.staging}:root",
            "arn:aws:iam::${var.account_ids.production}:root"
          ]
        }
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.captured_training_data_bucket.arn,
          "${aws_s3_bucket.captured_training_data_bucket.arn}/*"
        ]
      }
    ]
  })
}

# Create IAM role for cross-account access
resource "aws_iam_role" "captured_training_data_access_role" {
  name = "${var.project_name}-captured-dataset-access"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = [
            "arn:aws:iam::${var.account_ids.staging}:root",
            "arn:aws:iam::${var.account_ids.production}:root"
          ]
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Add policy to the role allowing access to the captured training data
resource "aws_iam_role_policy" "captured_training_data_access_policy" {
  name = "s3-captured-dataset-access"
  role = aws_iam_role.captured_training_data_access_role.id
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.captured_training_data_bucket.arn,
          "${aws_s3_bucket.captured_training_data_bucket.arn}/*"
        ]
      }
    ]
  })
}
