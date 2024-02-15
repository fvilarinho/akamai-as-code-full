# Definition of IP/GEO firewall protection.
resource "akamai_appsec_ip_geo_protection" "default" {
  config_id          = akamai_appsec_configuration.default.config_id
  security_policy_id = akamai_appsec_security_policy.default.security_policy_id
  enabled            = local.securitySettings.policies[0].ipGeoFirewall.enabled
  depends_on         = [ akamai_appsec_security_policy.default ]
}

resource "akamai_appsec_ip_geo_protection" "deny" {
  config_id          = akamai_appsec_configuration.default.config_id
  security_policy_id = akamai_appsec_security_policy.default.security_policy_id
  enabled            = local.securitySettings.policies[1].ipGeoFirewall.enabled
  depends_on         = [ akamai_appsec_security_policy.default ]
}

data "akamai_networklist_network_lists" "torNetwork" {
  name = "Tor Akamai Network List"
}

resource "akamai_appsec_ip_geo" "default" {
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default.security_policy_id
  mode                       = local.securitySettings.policies[0].ipGeoFirewall.mode
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

resource "akamai_appsec_ip_geo" "deny" {
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.deny.security_policy_id
  mode                       = local.securitySettings.policies[1].ipGeoFirewall.mode
  ukraine_geo_control_action = "none"
  geo_network_lists          = [ akamai_networklist_network_list.blockedGeos.id ]
  ip_network_lists           = [
    akamai_networklist_network_list.blockedIps.id,
    data.akamai_networklist_network_lists.torNetwork.id
  ]
  exception_ip_network_lists = [ akamai_networklist_network_list.allowedIps.id ]
  depends_on                 = [
    akamai_appsec_security_policy.deny,
    data.akamai_networklist_network_lists.torNetwork,
    akamai_networklist_network_list.allowedIps,
    akamai_networklist_network_list.blockedIps,
    akamai_networklist_network_list.blockedGeos
  ]
}