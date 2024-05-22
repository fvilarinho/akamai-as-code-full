# Definition of the Edge DNS TLS certificate validation entries.
data "akamai_property_hostnames" "default" {
  for_each    = { for property in local.propertySettings.hostnames : property.name => property }
  contract_id = local.generalSettings.contract
  group_id    = local.generalSettings.group
  property_id = akamai_property.default[each.key].id
  version     = akamai_property.default[each.key].latest_version
  depends_on  = [ akamai_property.default ]
}

resource "akamai_dns_record" "certificateValidation" {
  for_each   = { for property in local.propertySettings.hostnames : property.name => property }
  name       = data.akamai_property_hostnames.default[each.key].hostnames[0].cert_status[0].hostname
  recordtype = "CNAME"
  ttl        = 30
  zone       = local.dnsSettings.zone
  target     = [ data.akamai_property_hostnames.default[each.key].hostnames[0].cert_status[0].target ]
  depends_on = [ data.akamai_property_hostnames.default ]
}

# Definition of the Edge DNS general entries.
resource "akamai_dns_record" "records" {
  for_each   = { for record in local.dnsSettings.records: record.name => record }
  zone       = local.dnsSettings.zone
  name       = "${each.key}.${local.dnsSettings.zone}"
  recordtype = each.value.type
  ttl        = each.value.ttl
  target     = [ each.value.value ]
}

# Definition of the Edge DNS entries that point to the Edge Hostname.
resource "akamai_dns_record" "default" {
  for_each   = { for property in local.propertySettings.hostnames : property.name => property }
  zone       = local.dnsSettings.zone
  name       = "${each.key}.${local.dnsSettings.zone}"
  recordtype = "CNAME"
  ttl        = local.dnsSettings.defaultTtl
  target     = [ akamai_edge_hostname.default[each.key].edge_hostname ]
  depends_on = [ akamai_edge_hostname.default ]
}