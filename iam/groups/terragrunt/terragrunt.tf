resource "aws_iam_group" "terragrunt" {
  name = "terragrunt"
}

resource "aws_iam_group_policy_attachment" "terragrunt_data_administrator" {
  group      = aws_iam_group.terragrunt.name
  policy_arn = var.terragrunt_data_administrator_policy_arn
}

resource "aws_iam_group_policy_attachment" "assume_terragrunt_administrator" {
  group      = aws_iam_group.terragrunt.name
  policy_arn = var.assume_terragrunt_administrator_role_policy_arn
}
