# Definition of WAF protection.
resource "akamai_appsec_waf_protection" "default" {
  for_each           = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id          = akamai_appsec_configuration.default.config_id
  security_policy_id = akamai_appsec_security_policy.default[each.key].security_policy_id
  enabled            = each.value.waf.enabled
  depends_on         = [ akamai_appsec_security_policy.default ]
}

# Definition of WAF mode.
resource "akamai_appsec_waf_mode" "default" {
  for_each           = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id          = akamai_appsec_configuration.default.config_id
  security_policy_id = akamai_appsec_waf_protection.default[each.key].security_policy_id
  mode               = "ASE_AUTO"
  depends_on         = [ akamai_appsec_security_policy.default ]
}