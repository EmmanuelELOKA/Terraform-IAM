#Get AWS Account ID of AWS Account
data "aws_caller_identity" "current" {}

# Create IAM role
# Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "iam_role" {
  name = "${var.name}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
      },
    ]
  })
}


# Create IAM Policy from the template json file in the folder policies
data "template_file" "iam_policy_template" {
  template = "${file("${path.module}/policies/iam_policy.json")}"
}

resource "aws_iam_role_policy" "iam_policy" {
  name = "${var.name}-policy"
  role = aws_iam_role.iam_role.id
  policy = data.template_file.iam_policy_template.rendered
}

# Create IAM Group Policy by referring to above policy created 
# Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy
resource "aws_iam_group_policy" "group_policy" {
  name  = "${var.name}-group-policy"
  group = aws_iam_group.group.name
  policy = data.template_file.iam_policy_template.rendered
}


# Create IAM Group 
# Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group
resource "aws_iam_group" "group" {
  name = "${var.name}-group"
}

# Create IAM User
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user
resource "aws_iam_user" "iam_user" {
  name = "${var.name}-user"
  path = "/"
}

# Assign IAM User to the Group
# Ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership
resource "aws_iam_user_group_membership" "group_attachment" {
  user = aws_iam_user.iam_user.name

  groups = [
    aws_iam_group.group.name
  ]
}