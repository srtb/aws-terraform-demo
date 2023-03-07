terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_budgets_budget" "demo_sam_budget" {
  name         = "demo_sam_budget"
  budget_type  = "COST"
  limit_amount = "11.0"
  limit_unit   = "USD"
  time_unit    = "MONTHLY"
}