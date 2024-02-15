# Definition of the CP Code used for reporting and billing.
resource "akamai_cp_code" "default" {
  contract_id = local.generalSettings.contract
  group_id    = local.generalSettings.group
  product_id  = local.propertySettings.product
  name        = local.propertySettings.id
}