locals {
  account_id         = data.aws_caller_identity.current.account_id
  region             = data.aws_region.current.name
  user_id            = data.aws_canonical_user_id.current.id
  application_tags   = data.aws_servicecatalogappregistry_application.minhoteca_application.tags
  lambda_trigger_arn = "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${var.lambda_trigger_name}"
  kms_arn            = data.aws_kms_key.kms_sender.arn
}
