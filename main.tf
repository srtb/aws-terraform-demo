terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.account_access_key
  secret_key = var.account_secret_key
}

# Declares the local variables
locals {
  user_group_json   = jsondecode(file("${path.module}/input/user_data/user_groups.json"))
  groups_roles_json = jsondecode(file("${path.module}/input/user_data/groups_roles.json"))
}

resource "aws_budgets_budget" "demo_sam_budget" {
  name         = "demo_sam_budget"
  budget_type  = "COST"
  limit_amount = "10.0"
  limit_unit   = "USD"
  time_unit    = "MONTHLY"
}

module "create-users" {
  source = "./modules/users"

  for_each  = local.user_group_json
  user_name = each.key
}

module "create-groups" {
  source = "./modules/groups"

  for_each   = local.groups_roles_json
  group_name = each.key
  path       = "/users/"
}

module "add-group-roles" {
  source = "./modules/group-policies"

  for_each   = local.groups_roles_json
  group_name = each.key
  role_arns  = each.value.roles

  depends_on = [
    module.create-groups
  ]
}

module "add-user-groups" {
  source = "./modules/user-groups"

  for_each    = local.user_group_json
  user_name   = each.key
  group_names = each.value.groups

  depends_on = [
    module.create-users,
    module.create-groups
  ]
}