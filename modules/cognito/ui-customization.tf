resource "aws_cognito_user_pool_ui_customization" "ui" {
  user_pool_id = aws_cognito_user_pool_domain.domain.user_pool_id

  css        = file(var.css_file_path)
  image_file = filebase64(var.logo_file_path)
}
