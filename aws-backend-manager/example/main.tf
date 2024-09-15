variable "ENV" {}

module "backend" {
  source = "../."
  # source  = "Apollo-XIV/backend-manager/aws"
  # version = "0.0.11"
  prefix = "backend-test"

  output_dir = abspath(path.root)

  environment_configs_dir = abspath(path.root)
  environments = [
    "dev",
    "staging"
  ]
  ENV = var.ENV

  variables = {
    cidr = "string"
  }

  approved_arns = [
    data.aws_caller_identity.current.arn
  ]
  force_destroy = true
}

data "aws_caller_identity" "current" {}
# this comment is triggering a version rebuild
