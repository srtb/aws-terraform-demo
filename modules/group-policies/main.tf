data "aws_iam_policy_document" "sts-assume-policy-document" {
    statement {
        actions = ["sts:AssumeRole"]
        effect = "Allow"
        resources = var.role_arns
    }
}

resource "aws_iam_policy" "access-policy" {
    name = "${var.group_name}-access-policy"
    description = "The ${var.group_name} access policy"
    policy = data.aws_iam_policy_document.sts-assume-policy-document.json
}

resource "aws_iam_policy_attachment" "policy-attachment" {
    name = "${var.group_name}-policy-attachment"
    groups = [var.group_name]
    policy_arn = aws_iam_policy.access-policy.arn
}