locals {
  bucket_name        = aws_s3_bucket.state.bucket
  dynamodb_table_arn = aws_dynamodb_table.locking[var.ENV].arn
  bucket_key         = "${var.prefix}-${var.ENV}.tfstate"
  role_arn           = aws_iam_role.iac_role.arn
}
