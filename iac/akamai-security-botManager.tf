# Definition of the Bot Management protection.
resource "akamai_botman_bot_management_settings" "default" {
  for_each                = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id               = akamai_appsec_configuration.default.config_id
  security_policy_id      = akamai_appsec_security_policy.default[each.key].security_policy_id
  bot_management_settings = jsonencode(each.value.botManager.general)
  depends_on              = [ akamai_appsec_security_policy.default ]
}