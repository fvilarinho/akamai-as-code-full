# Definition of the WAF protection.
resource "akamai_appsec_waf_protection" "default" {
  config_id          = akamai_appsec_configuration.default.config_id
  security_policy_id = akamai_appsec_security_policy.default.security_policy_id
  enabled            = local.securitySettings.policies[0].waf.enabled
  depends_on         = [ akamai_appsec_security_policy.default ]
}

resource "akamai_appsec_waf_protection" "deny" {
  config_id          = akamai_appsec_configuration.default.config_id
  security_policy_id = akamai_appsec_security_policy.deny.security_policy_id
  enabled            = local.securitySettings.policies[1].waf.enabled
  depends_on         = [ akamai_appsec_security_policy.deny ]
}

# Definition of the WAF mode.
resource "akamai_appsec_waf_mode" "default" {
  config_id          = akamai_appsec_configuration.default.config_id
  security_policy_id = akamai_appsec_waf_protection.default.security_policy_id
  mode               = "ASE_AUTO"
  depends_on         = [ akamai_appsec_security_policy.default ]
}

resource "akamai_appsec_waf_mode" "deny" {
  config_id          = akamai_appsec_configuration.default.config_id
  security_policy_id = akamai_appsec_waf_protection.deny.security_policy_id
  mode               = "ASE_AUTO"
  depends_on         = [ akamai_appsec_security_policy.deny ]
}

# Definition of the WAF attack groups.
resource "akamai_appsec_attack_group" "default" {
  for_each            = { for attackGroup in local.securitySettings.policies[0].waf.attackGroups: attackGroup.id => attackGroup }
  config_id           = akamai_appsec_configuration.default.config_id
  security_policy_id  = akamai_appsec_waf_protection.default.security_policy_id
  attack_group        = each.key
  attack_group_action = each.value.action
  depends_on          = [ akamai_appsec_waf_protection.default ]
}

resource "akamai_appsec_attack_group" "deny" {
  for_each            = { for attackGroup in local.securitySettings.policies[1].waf.attackGroups: attackGroup.id => attackGroup }
  config_id           = akamai_appsec_configuration.default.config_id
  security_policy_id  = akamai_appsec_waf_protection.deny.security_policy_id
  attack_group        = each.key
  attack_group_action = each.value.action
  depends_on          = [ akamai_appsec_waf_protection.deny ]
}

resource "akamai_appsec_penalty_box" "default" {
  config_id              = akamai_appsec_configuration.default.config_id
  security_policy_id     = akamai_appsec_waf_protection.default.security_policy_id
  penalty_box_action     = local.securitySettings.policies[0].waf.penaltyBox.action
  penalty_box_protection = local.securitySettings.policies[0].waf.penaltyBox.enabled
  depends_on             = [ akamai_appsec_waf_protection.default ]
}

resource "akamai_appsec_penalty_box" "deny" {
  config_id              = akamai_appsec_configuration.default.config_id
  security_policy_id     = akamai_appsec_waf_protection.deny.security_policy_id
  penalty_box_action     = local.securitySettings.policies[1].waf.penaltyBox.action
  penalty_box_protection = local.securitySettings.policies[1].waf.penaltyBox.enabled
  depends_on             = [ akamai_appsec_waf_protection.deny ]
}
