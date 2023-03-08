terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {   
    region = var.region
    access_key = var.account_access_key
    secret_key = var.account_secret_key   
}

# Declares the local variables
locals {    
    user_json = jsondecode(file("${path.module}/input/user_data/user_json.json"))
    user_groups = ["Dev","Platform-Engineer", "Database-Administrator"]
    environments = ["Dev","pre-prod"]    
}

resource "aws_budgets_budget" "demo_sam_budget" {
  name         = "demo_sam_budget"
  budget_type  = "COST"
  limit_amount = "10.0"
  limit_unit   = "USD"
  time_unit    = "MONTHLY"
}

# Creates the users
module "users-creation" {
    source = "./modules/user-accounts"

    user_json = local.user_json
}
