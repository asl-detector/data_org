resource "aws_s3_bucket" "extrn_training_data_bucket" {
  bucket        = "${var.project_name}-extrn-raw-training-${var.uuid}"
  force_destroy = false
}

resource "aws_s3_bucket_server_side_encryption_configuration" "extrn_training_data_bucket_encryption" {
  bucket = aws_s3_bucket.extrn_training_data_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "extrn_training_data_bucket_public_access" {
  bucket = aws_s3_bucket.extrn_training_data_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Add bucket policy for cross-account access from development and operations accounts
resource "aws_s3_bucket_policy" "extrn_training_data_cross_account" {
  bucket = aws_s3_bucket.extrn_training_data_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = [
            "arn:aws:iam::${var.account_ids.development}:root",
            "arn:aws:iam::${var.account_ids.operations}:root"
          ]
        }
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.extrn_training_data_bucket.arn,
          "${aws_s3_bucket.extrn_training_data_bucket.arn}/*"
        ]
      }
    ]
  })
}

# Create IAM role for cross-account access
resource "aws_iam_role" "extrn_training_data_access_role" {
  name = "${var.project_name}-extrn-dataset-access"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = [
            "arn:aws:iam::${var.account_ids.development}:root",
            "arn:aws:iam::${var.account_ids.operations}:root"
          ]
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Add policy to the role allowing access to the external training data
resource "aws_iam_role_policy" "extrn_training_data_access_policy" {
  name = "s3-extrn-dataset-access"
  role = aws_iam_role.extrn_training_data_access_role.id
  
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
          aws_s3_bucket.extrn_training_data_bucket.arn,
          "${aws_s3_bucket.extrn_training_data_bucket.arn}/*"
        ]
      }
    ]
  })
}
