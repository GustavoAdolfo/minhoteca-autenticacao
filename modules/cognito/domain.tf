resource "aws_cognito_user_pool_domain" "domain" {
  user_pool_id = aws_cognito_user_pool.pool.id
  domain       = var.default_name
}
