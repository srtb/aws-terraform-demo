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



#MINE


# resource "aws_iam_role" "group_roles" {
#   for_each = var.user_group_json

#   name = each.key
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect    = "Allow"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#         Action    = "sts:AssumeRole"
#       }
#     ]
#   })
# }



# resource "aws_iam_role_policy_attachment" "group_role_attachments" {
#   for_each = {
#     for group_name, group in var.user_group_json : group_name => group.roles
#   }

#   policy_arn = "arn:aws:iam::aws:policy/${each.value}"
#   role       = aws_iam_role.group_roles[each.key].name
# }
