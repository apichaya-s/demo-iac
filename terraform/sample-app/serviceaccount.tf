locals {
  name_prefix = "${var.service}-${var.environment}"
  account_id  = data.aws_caller_identity.current.account_id
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "this" {
  statement {
    sid    = "AllowS3"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject",
    ]
    resources = [
      "arn:aws:s3:::my-web-assets",
      "arn:aws:s3:::my-web-assets/*",
    ]
  }
  statement {
    sid    = "AllowSQS"
    effect = "Allow"
    actions = [
      "sqs:DeleteMessage",
      "sqs:GetQueueUrl",
      "sqs:ReceiveMessage",
      "sqs:SendMessage",
    ]
    resources = [
      "arn:aws:sqs:ap-southeast-1:${local.account_id}:lms-import-data",
    ]
  }
}


resource "aws_iam_policy" "this" {
  name        = "${local.name_prefix}-serviceaccount-policy"
  path        = "/"
  description = "Policy for ${local.name_prefix}"
  policy      = data.aws_iam_policy_document.this.json
}

data "terraform_remote_state" "eks" {
  backend = "local"

  config = {
    path = "../eks"
  }
}

module "sample_app_sa_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = "${local.name_prefix}-serviceaccount-role"
  role_policy_arns = {
    policy = aws_iam_policy.this.arn
  }

  oidc_providers = {
    one = {
      provider_arn               = data.terraform_remote_state.eks.outputs.eks_oidc_provider_arn
      namespace_service_accounts = "${var.namespace}:${local.name_prefix}"
    }
  }
}
