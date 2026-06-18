variable "default_name" { type = string }
variable "deletion_protection" { type = string }
variable "default_email" { type = string }
variable "arn_lambda_trigger" { type = string }
variable "application_tags" { type = map(string) }
variable "mfa_configuration" { type = string }
variable "reply_to_email_address" { type = string }
variable "ses_verified_email_account" { type = string }
variable "css_file_path" { type = string }
variable "logo_file_path" { type = string }

variable "client" {
  type = object({
    access_token_validity  = number
    id_token_validity      = number
    refresh_token_validity = number
    unit_access_token      = string
    unit_id_token          = string
    unit_refresh_token     = string
    callback_urls          = list(string)
    default_redirect       = string
    logout_urls            = list(string)
  })
}
