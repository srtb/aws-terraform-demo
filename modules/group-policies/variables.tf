variable "role_arns" {
    description = "A list of role arns to assign to the group"
    type = list(string)
}

variable "group_name" {
    description = "The group associated with the policy"
    type = string
}