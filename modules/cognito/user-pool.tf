resource "aws_cognito_user_pool" "pool" {
  name = var.default_name

  admin_create_user_config {
    allow_admin_create_user_only = false
    invite_message_template {
      email_message = "Olá {username}!<br/><br/>Esta é sua senha provisória para acesso à Minhoteca: {####} <br/><br/>Você deverá alterá-la após o primeiro acesso."
      email_subject = "Boas vindas!"
      sms_message   = "Olá {username}! Para seu primeiro acesso, use a senha {####}"
    }
  }

  auto_verified_attributes = ["email"]

  deletion_protection = var.deletion_protection

  email_configuration {
    email_sending_account  = "DEVELOPER"
    from_email_address     = "Minhoteca <${var.default_email}>"
    reply_to_email_address = var.reply_to_email_address
    source_arn             = var.ses_verified_email_account
  }
  lambda_config {
    # custom_message               = var.lambda_cognitoTriggers_arn # (Optional) Custom Message AWS Lambda trigger.
    # custom_email_sender          = var.lambda_cognitoTriggers_arn # (Optional) A custom email sender AWS Lambda trigger. See custom_email_sender Below.
    define_auth_challenge          = var.lambda_cognitoTriggers_arn # (Optional) Defines the authentication challenge.
    create_auth_challenge          = var.lambda_cognitoTriggers_arn # (Optional) ARN of the lambda creating an authentication challenge.
    verify_auth_challenge_response = var.lambda_cognitoTriggers_arn # (Optional) Verifies the authentication challenge response.
    pre_sign_up                    = var.lambda_cognitoTriggers_arn # (Optional) Pre-registration AWS Lambda trigger.
    post_confirmation              = var.lambda_cognitoTriggers_arn # (Optional) Post-confirmation AWS Lambda trigger.
    pre_authentication             = var.lambda_cognitoTriggers_arn # (Optional) Pre-authentication AWS Lambda trigger.
    pre_token_generation           = var.lambda_cognitoTriggers_arn # (Optional) Allow to customize identity token claims before token generation.
    post_authentication            = var.lambda_cognitoTriggers_arn # (Optional) Post-authentication AWS Lambda trigger.
    kms_key_id                     = var.kms_key_arn                # (Optional) The Amazon Resource Name of Key Management Service Customer master keys. Amazon Cognito uses the key to encrypt codes and temporary passwords sent to CustomEmailSender and CustomSMSSender.
    custom_email_sender {
      # lambda_arn     = aws_lambda_alias.customMessage.arn
      # lambda_arn = "arn:aws:lambda:us-east-1:067855005095:function:testes"
      lambda_arn     = var.lambda_cognitoTriggers_arn
      lambda_version = "V1_0"
    }
    # user_migration - (Optional) User migration Lambda config type.
    # custom_sms_sender - (Optional) A custom SMS sender AWS Lambda trigger. See custom_sms_sender Below.
  }
  mfa_configuration = var.mfa_configuration

  schema {
    name                     = "email"
    attribute_data_type      = "String"
    mutable                  = true
    required                 = true
    developer_only_attribute = false
    string_attribute_constraints {
      max_length = "2048"
      min_length = "5"
    }
  }

  schema {
    name                     = "acknowledgement"
    attribute_data_type      = "Boolean"
    mutable                  = true
    required                 = false
    developer_only_attribute = false
  }

  schema {
    name                     = "acknowledgement_date"
    attribute_data_type      = "DateTime"
    mutable                  = true
    required                 = false
    developer_only_attribute = false
  }
  schema {
    name                     = "acknowledgement_term"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = false
  }
  schema {
    name                     = "zipcode"
    attribute_data_type      = "Number"
    mutable                  = true
    required                 = false
    developer_only_attribute = false
    number_attribute_constraints {
      max_value = "99999999"
      min_value = "1001"
    }
  }
  schema {
    name                     = "newUser"
    attribute_data_type      = "Boolean"
    mutable                  = true
    required                 = false
    developer_only_attribute = false
  }
  schema {
    name                     = "borrowApproved"
    attribute_data_type      = "Boolean"
    mutable                  = true
    required                 = false
    developer_only_attribute = false
  }

  sms_authentication_message = "Seu código de autenticação na Minhoteca: {####}"
  username_attributes        = ["email"]
  tags                       = merge(var.application_tags, { Contexto = "Auth" })
  username_configuration {
    case_sensitive = false
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    # email_message         = "Para confirmar sua conta na ${var.name} use o código {####}"
    email_message         = "Olá {username}! Para confirmar sua conta na Minhoteca utilize o código {####}."
    email_message_by_link = "Confirme seu cadastro na Minhoteca através deste {##LINK##}. Se preferir, clique com o botão direito sobre o {##LINK##}, copie o endereço e colee-o na barra de endereço do navegador."
    email_subject         = "Confirme sua conta na Minhoteca"
    email_subject_by_link = "Confirme sua conta na Minhoteca"
    sms_message           = "Seu código de confirmação na Minhoteca: {####}"
  }

  lifecycle {
    ignore_changes = [
      schema
    ]
  }
}

output "user_pool_id" {
  value = aws_cognito_user_pool.pool.id
}
output "user_pool_arn" {
  value = aws_cognito_user_pool.pool.arn
}
