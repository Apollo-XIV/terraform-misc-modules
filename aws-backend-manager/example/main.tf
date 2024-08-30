variable "ENV" {}

module "backend" {
  source = "../."
  prefix = "backend-test"

  output_dir = path.root

  environment_configs_dir = path.root
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
}

data "aws_caller_identity" "current" {}
