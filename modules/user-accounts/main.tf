# Creates the users for each user defined in var.user_json and assigns them to the user groups
module "users" {
    source = "./users"

    for_each = var.user_json
    user_name = each.key
}

# Establishes the group memberships for each user defined in var.user_json
# module "group-membership" {
#     source = "./group-membership"

#     for_each = var.user_json
#     user_name = each.key
#     group_names = each.value.groups
# }