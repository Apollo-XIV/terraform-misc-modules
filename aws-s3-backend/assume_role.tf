resource "aws_iam_role" "iac_role" {
  name = "${var.prefix}-iac-role"

  # Define the trust relationship policy that allows Terraform to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = var.approved_arns
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "terraform_role_admin_access" {
  role       = aws_iam_role.iac_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Create the IAM group
resource "aws_iam_group" "infrastructure_user_group" {
  name = "${var.prefix}-iac-users"
}

# Attach the policy to allow group members to assume the role
resource "aws_iam_group_policy" "infrastructure_user_policy" {
  group = aws_iam_group.infrastructure_user_group.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "sts:AssumeRole",
        Resource = aws_iam_role.iac_role.arn
      }
    ]
  })
}
