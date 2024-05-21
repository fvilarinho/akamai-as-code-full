# Definition of IP/GEO firewall protection.
resource "akamai_appsec_ip_geo_protection" "default" {
  for_each           = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id          = akamai_appsec_configuration.default.config_id
  security_policy_id = akamai_appsec_security_policy.default[each.key].security_policy_id
  enabled            = each.value.ipGeoFirewall.enabled
  depends_on         = [ akamai_appsec_security_policy.default ]
}

# Definition of IP/GEO firewall rules.
resource "akamai_appsec_ip_geo" "default" {
  for_each                   = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default[each.key].security_policy_id
  mode                       = each.value.ipGeoFirewall.mode
  ukraine_geo_control_action = "none"
  geo_network_lists          = [ akamai_networklist_network_list.blockedGeos.id ]
  ip_network_lists           = [
    akamai_networklist_network_list.blockedIps.id,
    data.akamai_networklist_network_lists.torNetwork.id
  ]
  exception_ip_network_lists = [ akamai_networklist_network_list.allowedIps.id ]
  depends_on                 = [
    akamai_appsec_security_policy.default,
    data.akamai_networklist_network_lists.torNetwork,
    akamai_networklist_network_list.allowedIps,
    akamai_networklist_network_list.blockedIps,
    akamai_networklist_network_list.blockedGeos
  ]
}