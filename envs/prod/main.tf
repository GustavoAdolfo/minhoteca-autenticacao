terraform {
  required_version = "~> 1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Terraform = true
      Projeto   = "Minhoteca"
    }
  }
}

module "cognito" {
  source                     = "../../modules/cognito"
  deletion_protection        = var.deletion_protection
  default_name               = var.default_name
  ses_verified_email_account = var.ses_verified_email_account
  default_email              = var.default_email
  reply_to_email_address     = var.reply_to_email_address
  mfa_configuration          = var.mfa_configuration
  css_file_path              = var.css_file_path
  logo_file_path             = var.logo_file_path
  application_tags           = local.application_tags
  lambda_cognitoTriggers_arn = local.lambda_trigger_arn
  kms_key_arn                = local.kms_arn
  client = {
    access_token_validity  = var.access_token_validity
    id_token_validity      = var.id_token_validity
    refresh_token_validity = var.refresh_token_validity
    unit_access_token      = var.unit_access_token
    unit_id_token          = var.unit_id_token
    unit_refresh_token     = var.unit_refresh_token
    callback_urls          = var.callback_urls
    default_redirect       = var.default_redirect
    logout_urls            = var.logout_urls
  }
}
