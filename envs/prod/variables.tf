variable "appregistry_id" {
  type        = string
  description = "ID da aplicação no Service Catalog App Registry"
}
variable "css_file_path" {
  type        = string
  description = "Caminho para o arquivo CSS de customização da UI do Cognito"
}
variable "logo_file_path" {
  type        = string
  description = "Caminho para o arquivo de logo (PNG ou JPEG) para customização da UI do Cognito"
}
variable "default_name" {
  type        = string
  description = "Nome padrão para o User Pool"
}
variable "deletion_protection" {
  type        = string
  description = "Habilita ou desabilita a proteção contra exclusão do User Pool. Valores válidos: 'ENABLED' ou 'DISABLED'."
}
variable "default_email" {
  type        = string
  description = "Endereço de e-mail padrão para o User Pool"
}
variable "mfa_configuration" {
  type        = string
  description = "Configuração de MFA (Multi-Factor Authentication) para o User Pool"
}
variable "reply_to_email_address" {
  type        = string
  description = "Endereço de e-mail para resposta automática do User Pool"
}
variable "ses_verified_email_account" {
  type        = string
  description = "Endereço de e-mail verificado no SES para envio de e-mails do Cognito"
}
variable "access_token_validity" {
  type        = number
  description = "Validade do token de acesso"
}
variable "id_token_validity" {
  type        = number
  description = "Validade do token ID"
}
variable "refresh_token_validity" {
  type        = number
  description = "Validade do token de atualização"
}
variable "unit_access_token" {
  type        = string
  description = "Unidade de tempo para a validade do token de acesso"
}
variable "unit_id_token" {
  type        = string
  description = "Unidade de tempo para a validade do token ID"
}
variable "unit_refresh_token" {
  type        = string
  description = "Unidade de tempo para a validade do token de atualização"
}
variable "callback_urls" {
  type        = list(string)
  description = "URLs de callback para o User Pool"
}
variable "default_redirect" {
  type        = string
  description = "URL de redirecionamento padrão para o User Pool"
}
variable "logout_urls" {
  type        = list(string)
  description = "URLs de logout para o User Pool"
}
variable "lambda_trigger_name" {
  type        = string
  description = "Nome da função Lambda para os triggers do Cognito"
}
variable "kms_key_id" {
  type        = string
  description = "ID da chave KMS para criptografia de códigos e senhas temporárias do Cognito"
}
