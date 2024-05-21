# Definition of WAF penalty box.
resource "akamai_appsec_penalty_box" "default" {
  for_each               = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id              = akamai_appsec_configuration.default.config_id
  security_policy_id     = akamai_appsec_waf_protection.default[each.key].security_policy_id
  penalty_box_action     = each.value.waf.penaltyBox.action
  penalty_box_protection = each.value.waf.penaltyBox.enabled
  depends_on             = [ akamai_appsec_waf_protection.default ]
}
