locals {
  bucket_name        = module.s3_backend.bucket
  dynamodb_table_arn = module.s3_backend.lock_tables[var.ENV]
  bucket_key         = "${var.prefix}-${var.ENV}.tfstate"
  role_arn           = module.s3_backend.role_arn
}

module "s3_backend" {
  source  = "Apollo-XIV/s3-backend/aws"
  version = "0.0.5"
  prefix  = var.prefix

  environments  = var.environments
  approved_arns = var.approved_arns
}

module "env_gen" {
  source       = "Apollo-XIV/env-gen/local"
  version      = "0.0.8"
  ENV          = var.ENV
  environments = var.environments
  variables    = var.variables

  environment_configs_dir = var.environment_configs_dir
  output_dir              = var.output_dir
}
