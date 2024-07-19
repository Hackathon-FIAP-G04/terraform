resource "aws_cognito_user_pool" "cognito" {
  name = "${var.prefix}-user-pool"

  password_policy {
    minimum_length = 8
  }

  alias_attributes         = ["preferred_username"]
  auto_verified_attributes = ["email"]

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  schema {
    name                = "email"
    attribute_data_type = "String"
    mutable             = true
    required            = true
  }

  schema {
    name                = "given_name"
    attribute_data_type = "String"
    mutable             = false
    required            = true
  }

  schema {
    name                = "family_name"
    attribute_data_type = "String"
    mutable             = false
    required            = true
  }

  schema {
    name                = "customerId"
    attribute_data_type = "String"
    mutable             = false
    string_attribute_constraints {
      min_length = 36
      max_length = 36
    }
  }
}

resource "aws_cognito_user_pool_client" "cognito" {
  name = "${var.prefix}-user-pool-client"

  generate_secret = false
  explicit_auth_flows = [ 
    "ALLOW_REFRESH_TOKEN_AUTH", 
    "ALLOW_USER_PASSWORD_AUTH", 
    "ALLOW_USER_SRP_AUTH" 
    ]
  user_pool_id    = aws_cognito_user_pool.cognito.id
}

resource "aws_cognito_user_pool_domain" "cognito" {
  domain       = "${var.cognito_domain}"
  user_pool_id = aws_cognito_user_pool.cognito.id
}
