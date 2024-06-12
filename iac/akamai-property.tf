locals {
  datastreamAvailable = compact([ for stream in data.akamai_datastreams.default.streams_details : ( stream.stream_name == local.propertySettings.dataStream ? stream.stream_id : null)])
}

data "akamai_datastreams" "default" {
  group_id = local.generalSettings.group
}


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
    value = replace(akamai_cp_code.default[each.key].id, "cpc_", "")
  }

  variables {
    name  = "dataStreamEnabled"
    type  = "bool"
    value = (length(local.datastreamAvailable) > 0 ? true : false)
  }

  variables {
    name  = "dataStreamAvailable"
    type  = "jsonBlock"
    value = jsonencode(local.datastreamAvailable)
  }

  depends_on = [
    linode_object_storage_bucket.default,
    akamai_cp_code.default
  ]
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

# Activates the property (CDN configuration) in staging network.
resource "akamai_property_activation" "staging" {
  for_each                       = { for property in local.propertySettings.hostnames : property.name => property }
  property_id                    = akamai_property.default[each.key].id
  version                        = akamai_property.default[each.key].latest_version
  contact                        = [ local.generalSettings.email ]
  note                           = local.propertySettings.notes
  network                        = "STAGING"
  auto_acknowledge_rule_warnings = true
  depends_on                     = [ akamai_property.default ]
}

# Activates the property (CDN configuration) in production network.
resource "akamai_property_activation" "production" {
  for_each                       = { for property in local.propertySettings.hostnames : property.name => property }
  property_id                    = akamai_property.default[each.key].id
  version                        = akamai_property.default[each.key].latest_version
  contact                        = [ local.generalSettings.email ]
  note                           = local.propertySettings.notes
  network                        = "PRODUCTION"
  auto_acknowledge_rule_warnings = true

  compliance_record {
    noncompliance_reason_no_production_traffic {
    }
  }

  depends_on = [ akamai_property_activation.staging ]
}