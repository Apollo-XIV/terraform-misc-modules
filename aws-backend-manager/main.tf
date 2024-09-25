locals {
  bucket_name        = module.s3_backend.bucket
  dynamodb_table_arn = try(module.s3_backend.lock_tables[var.ENV], "")
  bucket_key         = "${var.prefix}-${var.ENV}.tfstate"
  role_arn           = module.s3_backend.role_arn
}

module "s3_backend" {
  source  = "Apollo-XIV/s3-backend/aws"
  version = "0.0.14"
  prefix  = var.prefix

  environments    = var.environments
  approved_arns   = var.approved_arns
  force_destroy   = var.force_destroy
  enable_dynamodb = var.enable_dynamodb
}

module "env_gen" {
  source       = "Apollo-XIV/env-gen/local"
  version      = "0.0.20"
  ENV          = var.ENV
  environments = var.environments
  variables = merge(var.variables, {
    env      = "string"
    role_arn = "string"
  })
  passthrough = {
    env      = var.ENV
    role_arn = local.role_arn
  }

  environment_configs_dir = var.environment_configs_dir
  output_dir              = var.output_dir
}
