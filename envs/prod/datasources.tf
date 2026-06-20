data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_canonical_user_id" "current" {}

data "aws_servicecatalogappregistry_application" "minhoteca_application" {
  id = var.appregistry_id
}

data "aws_lambda_function" "cognitoTriggers" {
  function_name = var.lambda_trigger_name
}

data "aws_kms_key" "kms_sender" {
  key_id = var.kms_key_id
}
