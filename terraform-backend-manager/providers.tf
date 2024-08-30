terraform {
  required_version = ">=1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.60.0"
    }
    local = {
      source = "hashicorp/local"
    }
    terraform = {
      source = "terraform.io/builtin/terraform"
    }
  }
}
