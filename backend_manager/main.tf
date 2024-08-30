locals {
  bucket_name        = module.s3_backend.bucket
  dynamodb_table_arn = module.s3_backend.lock_tables[var.ENV]
  bucket_key         = "${var.prefix}-${var.ENV}.tfstate"
  role_arn           = module.s3_backend.role_arn
}

module "s3_backend" {
  source = "../s3_backend"
  prefix = var.prefix

  environments  = var.environments
  approved_arns = var.approved_arns
}

module "env_gen" {
  source       = "../env_gen"
  ENV          = var.ENV
  environments = var.environments
  variables    = var.variables

  environment_configs_dir = var.environment_configs_dir
  output_dir              = var.output_dir
}
