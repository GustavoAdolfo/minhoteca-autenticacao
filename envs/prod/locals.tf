locals {
  account_id       = data.aws_caller_identity.current.account_id
  region           = data.aws_region.current.name
  user_id          = data.aws_canonical_user_id.current.id
  application_tags = data.aws_servicecatalogappregistry_application.minhoteca_application.tags
}
