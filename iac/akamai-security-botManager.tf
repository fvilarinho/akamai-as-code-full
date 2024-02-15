# Definition of the Bot Management protection.
resource "akamai_botman_bot_management_settings" "default" {
  config_id               = akamai_appsec_configuration.default.config_id
  security_policy_id      = akamai_appsec_security_policy.default.security_policy_id
  bot_management_settings = jsonencode(local.securitySettings.policies[0].botManager.general)
  depends_on              = [ akamai_appsec_security_policy.default ]
}

resource "akamai_botman_bot_management_settings" "deny" {
  config_id               = akamai_appsec_configuration.default.config_id
  security_policy_id      = akamai_appsec_security_policy.deny.security_policy_id
  bot_management_settings = jsonencode(local.securitySettings.policies[1].botManager.general)
  depends_on              = [ akamai_appsec_security_policy.deny ]
}

# Definition of the Bot Management detections.
resource "akamai_botman_akamai_bot_category_action" "default" {
  for_each                   = { for detection in local.securitySettings.policies[0].botManager.detections.akamai: detection.id => detection }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default.security_policy_id
  category_id                = each.key
  akamai_bot_category_action = jsonencode(each.value.details)
  depends_on                 = [ akamai_botman_bot_management_settings.default ]
}

resource "akamai_botman_akamai_bot_category_action" "deny" {
  for_each                   = { for detection in local.securitySettings.policies[1].botManager.detections.akamai: detection.id => detection }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.deny.security_policy_id
  category_id                = each.key
  akamai_bot_category_action = jsonencode(each.value.details)
  depends_on                 = [ akamai_botman_bot_management_settings.deny ]
}

resource "akamai_botman_bot_detection_action" "default" {
  for_each             = { for detection in local.securitySettings.policies[0].botManager.detections.activeAndTransparent: detection.id => detection }
  config_id            = akamai_appsec_configuration.default.config_id
  security_policy_id   = akamai_appsec_security_policy.default.security_policy_id
  detection_id         = each.key
  bot_detection_action = jsonencode(each.value.details)
  depends_on           = [ akamai_botman_bot_management_settings.default ]
}

resource "akamai_botman_bot_detection_action" "deny" {
  for_each             = { for detection in local.securitySettings.policies[1].botManager.detections.activeAndTransparent: detection.id => detection }
  config_id            = akamai_appsec_configuration.default.config_id
  security_policy_id   = akamai_appsec_security_policy.deny.security_policy_id
  detection_id         = each.key
  bot_detection_action = jsonencode(each.value.details)
  depends_on           = [ akamai_botman_bot_management_settings.deny ]
}