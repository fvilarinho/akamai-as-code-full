# Definition of the security configuration.
resource "akamai_appsec_configuration" "default" {
  contract_id = local.generalSettings.contract
  group_id    = local.generalSettings.group
  name        = local.securitySettings.id
  description = local.securitySettings.description
  host_names  = local.propertySettings.hostnames
  depends_on  = [ akamai_property_activation.default ]
}

data "akamai_appsec_configuration" "default" {
  name       = akamai_appsec_configuration.default.name
  depends_on = [ akamai_appsec_configuration.default ]
}

# Definition of the security configuration activation.
resource "akamai_appsec_activations" "default" {
  config_id           = akamai_appsec_configuration.default.config_id
  note                = local.securitySettings.versionNotes
  notification_emails = [ local.generalSettings.organization.technicalContact.email ]
  version             = data.akamai_appsec_configuration.default.latest_version
  network             = var.network
  depends_on          = [
    akamai_appsec_configuration.default,
    akamai_networklist_network_list.allowedIps,
    akamai_networklist_network_list.blockedIps,
    akamai_networklist_network_list.blockedGeos,
    akamai_appsec_security_policy.default,
    akamai_appsec_security_policy.deny,
    akamai_appsec_match_target.default,
    akamai_appsec_match_target.deny,
    akamai_appsec_rate_protection.default,
    akamai_appsec_rate_protection.deny,
    akamai_appsec_rate_policy.edgeRateLimits,
    akamai_appsec_rate_policy.originRateLimits,
    akamai_appsec_rate_policy_action.defaultEdgeRateLimits,
    akamai_appsec_rate_policy_action.defaultOriginRateLimits,
    akamai_appsec_slowpost_protection.default,
    akamai_appsec_slowpost_protection.deny,
    akamai_appsec_slow_post.default,
    akamai_appsec_slow_post.deny,
    akamai_appsec_ip_geo_protection.default,
    akamai_appsec_ip_geo_protection.deny,
    akamai_appsec_ip_geo.default,
    akamai_appsec_ip_geo.deny,
    akamai_appsec_waf_protection.default,
    akamai_appsec_waf_protection.deny,
    akamai_appsec_waf_mode.default,
    akamai_appsec_waf_mode.deny,
    akamai_appsec_attack_group.default,
    akamai_appsec_attack_group.deny,
    akamai_appsec_penalty_box.default,
    akamai_appsec_penalty_box.deny,
    akamai_botman_bot_management_settings.default,
    akamai_botman_bot_management_settings.deny,
    akamai_botman_akamai_bot_category_action.default,
    akamai_botman_akamai_bot_category_action.deny,
    akamai_botman_bot_detection_action.default,
    akamai_botman_bot_detection_action.deny
  ]
}