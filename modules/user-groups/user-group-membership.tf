resource "aws_iam_user_group_membership" "add_user_group_membership" {
    user = var.user_name

    groups = var.group_names
}