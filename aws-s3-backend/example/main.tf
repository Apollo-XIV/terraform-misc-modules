
module "s3_backend" {
  source = "../."
  prefix = "example"
  environments = [
    "dev"
  ]

  approved_arns = [
    "arn:aws:iam::013948180024:user/desktop"
  ]
}
