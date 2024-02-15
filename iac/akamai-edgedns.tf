# Definition of the Edge DNS general entries.
resource "akamai_dns_record" "records" {
  for_each   = { for record in local.dnsSettings.records: record.id => record }
  zone       = local.dnsSettings.id
  name       = "${each.value.id}.${local.dnsSettings.id}"
  recordtype = each.value.type
  ttl        = each.value.ttl
  target     = [ each.value.value ]
}

# Definition of the Edge DNS entries that point to the Edge Hostname.
resource "akamai_dns_record" "default" {
  for_each   = toset(local.propertySettings.hostnames)
  zone       = local.dnsSettings.id
  name       = each.value
  recordtype = "CNAME"
  ttl        = local.dnsSettings.defaultTtl
  target     = [ akamai_edge_hostname.default.edge_hostname ]
  depends_on = [ akamai_edge_hostname.default ]
}