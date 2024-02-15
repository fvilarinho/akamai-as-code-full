# Definition of the property rules (CDN configuration).
data "akamai_property_rules_template" "default" {
  template_file = abspath("property/rules/main.json")

  # Definition of the Origin Hostname variable.
  variables {
    name  = "originHostname"
    type  = "string"
    value = linode_object_storage_bucket.default.hostname
  }

  # Definition of the CP Code variable.
  variables {
    name  = "cpCode"
    type  = "number"
    value = replace(akamai_cp_code.default.id, "cpc_", "")
  }

  # Version notes.
  variables {
    name  = "versionNotes"
    type  = "string"
    value = local.propertySettings.versionNotes
  }

  depends_on = [ linode_object_storage_bucket.default ]
}

# Definition of the property (CDN configuration).
resource "akamai_property" "default" {
  contract_id = local.generalSettings.contract
  group_id    = local.generalSettings.group
  product_id  = local.propertySettings.product
  name        = local.propertySettings.id
  rules       = data.akamai_property_rules_template.default.json

  # Definition of all hostnames of the property.
  dynamic "hostnames" {
    for_each = toset(local.propertySettings.hostnames)

    content {
      cname_from             = hostnames.value
      cname_to               = akamai_edge_hostname.default.edge_hostname
      cert_provisioning_type = "CPS_MANAGED"
    }
  }

  depends_on = [
    data.akamai_property_rules_template.default,
    akamai_edge_hostname.default
  ]
}

# Activates the property (CDN configuration).
resource "akamai_property_activation" "default" {
  property_id                    = akamai_property.default.id
  version                        = akamai_property.default.latest_version
  contact                        = [ local.generalSettings.organization.technicalContact.email ]
  note                           = local.propertySettings.versionNotes
  network                        = var.network
  auto_acknowledge_rule_warnings = true
  depends_on                     = [
    akamai_property.default,
    akamai_cps_dv_validation.default
  ]
}