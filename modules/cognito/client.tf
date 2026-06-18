resource "aws_cognito_user_pool_client" "client" {
  name         = "${var.default_name}-site"
  user_pool_id = aws_cognito_user_pool.pool.id

  access_token_validity  = var.client.access_token_validity
  id_token_validity      = var.client.id_token_validity
  refresh_token_validity = var.client.refresh_token_validity
  token_validity_units {
    access_token  = var.client.unit_access_token
    id_token      = var.client.unit_id_token
    refresh_token = var.client.unit_refresh_token
  }

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes = [
    "email",
    "openid",
    "profile",
    "phone",
    "aws.cognito.signin.user.admin"
  ]

  callback_urls        = var.client.callback_urls
  default_redirect_uri = var.client.default_redirect
  logout_urls          = var.client.logout_urls

  enable_token_revocation = true

  explicit_auth_flows = [
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]

  generate_secret = false

  prevent_user_existence_errors = "ENABLED"

  read_attributes = [
    "sub",
    "name",
    "email_verified",
    "custom:newUser",
    "custom:borrowApproved",
  ]

  supported_identity_providers = [
    "COGNITO"
  ]

  write_attributes = [
    "email",
    "name",
    "custom:acknowledgement",
    "custom:acknowledgement_date",
    "custom:acknowledgement_term",
    "birthdate",
    "address",
    "family_name",
    "profile",
    "locale",
    "phone_number",
    "picture",
    "custom:zipcode",
    "custom:newUser",
    "gender",
    "given_name",
    "middle_name",
    "nickname",
    "preferred_username",
    "website",
    "zoneinfo",
  ]

  depends_on = [aws_cognito_user_pool.pool]
}
