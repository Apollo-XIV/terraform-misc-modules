locals {
  base_conf = {
    bucket  = local.bucket_name
    region  = "eu-west-1"
    encrypt = true
    assume_role = {
      role_arn     = local.role_arn
      session_name = "${var.prefix}-iac"
    }
  }
  rec_conf = merge(local.base_conf, {
    key = "${var.prefix}-backend.tfstate"
  })
  output_conf = merge(local.base_conf, {
    key = "${var.prefix}-${var.ENV}.tfstate"
  })
}

resource "local_file" "backend" {
  filename        = "${var.output_dir}/backend.tf.json"
  file_permission = "0444"
  content = jsonencode({
    terraform = {
      backend = {
        s3 = local.output_conf
      }
    }
  })
}

resource "local_file" "rec_backend" {
  filename        = "backend.tf.json"
  file_permission = "0444"
  content = jsonencode({
    terraform = {
      backend = {
        s3 = local.rec_conf
      }
    }
  })
}
