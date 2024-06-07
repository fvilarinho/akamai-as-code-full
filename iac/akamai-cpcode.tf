# Definition of the CP Code used for reporting and billing.
resource "akamai_cp_code" "default" {
  for_each    = { for property in local.propertySettings.hostnames : property.name => property }
  contract_id = local.generalSettings.contract
  group_id    = local.generalSettings.group
  product_id  = local.propertySettings.product
  name        = "${local.propertySettings.name}-${each.value.origin.name}"
}