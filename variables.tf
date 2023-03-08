variable "account_access_key" {
    description = "The access key for the primary aws deployment user"
    type = string    
}

variable "account_secret_key" {
    description = "The secret key for the primary aws deployment user"
    type = string    
}

variable "region" {
    description = "The aws deployment region"
    type = string
    default = "eu-west-2"
}

