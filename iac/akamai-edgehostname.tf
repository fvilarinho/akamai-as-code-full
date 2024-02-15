# Definition of the Edge Hostname. This is the hostname that must be used in the Edge DNS entries
# of all hostnames that will pass through the CDN.
resource "akamai_edge_hostname" "default" {
  contract_id   = local.generalSettings.contract
  group_id      = local.generalSettings.group
  product_id    = local.propertySettings.product
  edge_hostname = "${local.propertySettings.id}.edgekey.net"
  ip_behavior   = local.propertySettings.ipVersion
  certificate   = akamai_cps_dv_enrollment.default.id
  depends_on    = [ akamai_cps_dv_enrollment.default ]
}