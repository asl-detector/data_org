resource "aws_s3_bucket" "captured_training_data_bucket" {
  bucket = "${var.project_name}-captured-raw-training-${var.uuid}"
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