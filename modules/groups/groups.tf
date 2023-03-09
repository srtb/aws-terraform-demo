resource "aws_iam_group" "user-group" {
    name = var.group_name
    path = var.path
}