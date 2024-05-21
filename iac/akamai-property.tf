# Definition of the property rules (CDN configuration).
data "akamai_property_rules_template" "default" {
  for_each      = { for property in local.propertySettings.hostnames : property.name => property }
  template_file = abspath("property/rules/main.json")

  # Definition of the Origin Hostname variable.
  variables {
    name  = "originHostname"
    type  = "string"
    value = linode_object_storage_bucket.default[each.key].hostname
  }

  # Definition of the CP Code variable.
  variables {
    name  = "cpCode"
    type  = "number"
    value = replace(akamai_cp_code.default.id, "cpc_", "")
  }
}

# Definition of the property (CDN configuration).
resource "akamai_property" "default" {
  for_each    = { for property in local.propertySettings.hostnames : property.name => property }
  contract_id = local.generalSettings.contract
  group_id    = local.generalSettings.group
  product_id  = local.propertySettings.product
  name        = "${local.propertySettings.name}-${each.value.origin.name}"
  rules       = data.akamai_property_rules_template.default[each.key].json

  # Definition of all hostnames of the property.
  hostnames {
    cname_from             = "${each.key}.${local.dnsSettings.zone}"
    cname_to               = akamai_edge_hostname.default[each.key].edge_hostname
    cert_provisioning_type = "DEFAULT"
  }

  depends_on = [
    data.akamai_property_rules_template.default,
    akamai_edge_hostname.default
  ]
}

# Activates the property (CDN configuration).
resource "akamai_property_activation" "default" {
  for_each                       = { for property in local.propertySettings.hostnames : property.name => property }
  property_id                    = akamai_property.default[each.key].id
  version                        = akamai_property.default[each.key].latest_version
  contact                        = [ local.generalSettings.email ]
  note                           = local.propertySettings.notes
  network                        = var.network
  auto_acknowledge_rule_warnings = true
  depends_on                     = [ akamai_property.default ]
}