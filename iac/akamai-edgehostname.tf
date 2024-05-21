# Definition of the Edge Hostname. This is the hostname that must be used in the Edge DNS entries
# of all hostnames that will pass through the CDN.
resource "akamai_edge_hostname" "default" {
  for_each      = { for property in local.propertySettings.hostnames : property.name => property }
  contract_id   = local.generalSettings.contract
  group_id      = local.generalSettings.group
  product_id    = local.propertySettings.product
  edge_hostname = "${local.propertySettings.name}-${each.value.origin.name}.edgesuite.net"
  ip_behavior   = local.propertySettings.ipVersion
}