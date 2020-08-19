resource "aws_organizations_account" "account" {
  name  = var.account_name
  email = "${var.account_email_slug}@${var.domain}"

  lifecycle {
    prevent_destroy = true
  }
}

module "assume_role_account_administrator" {
  source = "../utility/iam/create-role-in-different-account-with-assume"

  providers = {
    aws                = aws
    aws.assume_account = aws.member
  }

  account_name            = "${var.account_name}"
  account_id              = "${aws_organizations_account.account.id}"
  assume_role_policy_json = "${data.aws_iam_policy_document.crossaccount_assume_from_organisation.json}"
  role                    = "Administrator"
  role_policy_arn         = "${var.administrator_default_arn}"
}

data "aws_iam_policy_document" "assume_role_organisation_account_access" {
  statement {
    sid     = "Assume${title(var.account_name)}OrganizationAccountAccessRole"
    actions = ["sts:AssumeRole"]

    resources = [
      "arn:aws:iam::${aws_organizations_account.account.id}:role/OrganizationAccountAccessRole",
    ]
  }
}

resource "aws_iam_policy" "assume_role_organisation_account_access" {
  name        = "Assume${title(var.account_name)}OrganizationAccountAccessRole"
  policy      = data.aws_iam_policy_document.assume_role_organisation_account_access.json
  description = "Grants role assumption for the OrganizationAccountAccess role in the ${title(var.account_name)} account"
}

