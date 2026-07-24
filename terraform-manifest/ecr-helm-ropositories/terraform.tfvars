aws_region          = "ca-central-1"
awscli_user_profile = "dev-admin"

helm_repositories = {
  ui = {
    repository_name = "retail-store-ui-chart"
    keep_versions   = 10
    force_delete    = true
  }
  #   catalog = {
  #     repository_name = "retail-store-catalog-chart"
  #     keep_versions   = 10
  #     force_delete    = true
  #   }

  #   cart = {
  #     repository_name = "retail-store-cart-chart"
  #     keep_versions   = 10
  #     force_delete    = true
  #   }

  #   checkout = {
  #     repository_name = "retail-store-checkout-chart"
  #     keep_versions   = 10
  #     force_delete    = true
  #   }
}
