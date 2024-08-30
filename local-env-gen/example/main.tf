module "env_gen" {
  source     = "../."
  output_dir = path.root
  environments = [
    "dev",
  ]
  ENV = "dev"
  variables = {
    test    = "number"
    another = "string"
  }
}

