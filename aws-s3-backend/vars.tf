
variable "prefix" {
  type        = string
  description = "string used to prefix resource names and identify the project a resource belongs to"
}

variable "environments" {
  type        = list(string)
  description = "A list of possible environments"
}

variable "approved_arns" {
  type = list(string)
}

variable "force_destroy" {
  type    = bool
  default = false
}

output "bucket" {
  value = aws_s3_bucket.state.bucket
}

output "lock_tables" {
  value = { for k, v in aws_dynamodb_table.locking : k => v.arn }
}

output "role_arn" {
  value = aws_iam_role.iac_role.arn
}
