data "aws_iam_policy_document" "terragrunt_admin" {
  statement {
    sid = "AllowListAllS3Buckets"

    actions = [
      "s3:GetBucketLocation",
      "s3:ListAllMyBuckets"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowS3ActionsOnTerraformBucket"

    actions = [
      "s3:CreateBucket",
      "s3:ListBucket",
      "s3:GetBucketVersioning",
      "s3:PutBucketVersioning",
      "s3:GetBucketTagging",
      "s3:PutBucketTagging",
      "s3:GetEncryptionConfiguration",
      "s3:PutEncryptionConfiguration",
    ]

    resources = [
      "arn:aws:s3:::${var.tfstate_global_bucket}",
    ]
  }

  statement {
    sid = "AllowGetAndPutS3ActionsOnTerraformBucketPath"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${var.tfstate_global_bucket}/*",
    ]
  }

  statement {
    sid = "AllowCreateAndUpdateDynamoDBActionsOnTerraformLockTable"

    actions = [
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:DeleteItem",
      "dynamodb:DescribeTable",
      "dynamodb:CreateTable",
    ]

    resources = [
      "arn:aws:dynamodb:*:*:table/${var.tfstate_global_dynamodb}",
    ]
  }

  statement {
    sid = "AllowTagAndUntagDynamoDBActions"

    actions = [
      "dynamodb:TagResource",
      "dynamodb:UntagResource",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "terragrunt_admin" {
  name        = "TerragruntAdminAccess"
  policy      = "${data.aws_iam_policy_document.terragrunt_admin.json}"
  description = "Grants permissions to manage Terraform remote state"
}

module "assume_role_terragrunt_admin" {
  source = "../utility/create-role"

  account_name            = "master"
  account_id              = "${data.aws_caller_identity.current.account_id}"
  assume_role_policy_json = "${data.aws_iam_policy_document.crossaccount_assume_from_master.json}"
  role                    = "TerragruntAdministrator"
  role_policy_arn         = "${aws_iam_policy.terragrunt_admin.arn}"
}

data "aws_iam_policy_document" "terragrunt_reader" {
  statement {
    sid = "AllowListAllS3Buckets"

    actions = [
      "s3:GetBucketLocation",
      "s3:ListAllMyBuckets"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "AllowListS3ActionsOnTerraformBucket"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${var.tfstate_global_bucket}",
    ]
  }

  statement {
    sid = "AllowGetS3ActionsOnTerraformBucketPath"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${var.tfstate_global_bucket}/*",
    ]
  }
}

resource "aws_iam_policy" "terragrunt_reader" {
  name        = "TerragruntReadAccess"
  policy      = "${data.aws_iam_policy_document.terragrunt_reader.json}"
  description = "Grants permissions to read Terraform remote state"
}

module "assume_role_terragrunt_reader" {
  source = "../utility/create-role"

  account_name            = "master"
  account_id              = "${data.aws_caller_identity.current.account_id}"
  assume_role_policy_json = "${data.aws_iam_policy_document.crossaccount_assume_from_master.json}"
  role                    = "TerragruntReader"
  role_policy_arn         = "${aws_iam_policy.terragrunt_reader.arn}"
}
