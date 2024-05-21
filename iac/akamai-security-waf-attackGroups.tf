# Definition of WAF rules.

# Web Policy Violation.
resource "akamai_appsec_attack_group" "webPolicyViolation" {
  for_each            = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id           = akamai_appsec_configuration.default.config_id
  security_policy_id  = akamai_appsec_waf_protection.default[each.key].security_policy_id
  attack_group        = "POLICY"
  attack_group_action = each.value.waf.attackGroups.webPolicyViolation.action
  depends_on          = [ akamai_appsec_waf_protection.default ]
}

# Web Attack Tool.
resource "akamai_appsec_attack_group" "webAttackTool" {
  for_each            = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id           = akamai_appsec_configuration.default.config_id
  security_policy_id  = akamai_appsec_waf_protection.default[each.key].security_policy_id
  attack_group        = "WAT"
  attack_group_action = each.value.waf.attackGroups.webAttackTool.action
  depends_on          = [ akamai_appsec_waf_protection.default ]
}

# Web Protocol Attack.
resource "akamai_appsec_attack_group" "webProtocolAttack" {
  for_each            = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id           = akamai_appsec_configuration.default.config_id
  security_policy_id  = akamai_appsec_waf_protection.default[each.key].security_policy_id
  attack_group        = "PROTOCOL"
  attack_group_action = each.value.waf.attackGroups.webProtocolAttack.action
  depends_on          = [ akamai_appsec_waf_protection.default ]
}

# SQL Injection.
resource "akamai_appsec_attack_group" "sqlInjection" {
  for_each            = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id           = akamai_appsec_configuration.default.config_id
  security_policy_id  = akamai_appsec_waf_protection.default[each.key].security_policy_id
  attack_group        = "SQL"
  attack_group_action = each.value.waf.attackGroups.sqlInjection.action
  depends_on          = [ akamai_appsec_waf_protection.default ]
}

# XSS Injection.
resource "akamai_appsec_attack_group" "xssInjection" {
  for_each            = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id           = akamai_appsec_configuration.default.config_id
  security_policy_id  = akamai_appsec_waf_protection.default[each.key].security_policy_id
  attack_group        = "XSS"
  attack_group_action = each.value.waf.attackGroups.xssInjection.action
  depends_on          = [ akamai_appsec_waf_protection.default ]
}

# Command Injection.
resource "akamai_appsec_attack_group" "commandInjection" {
  for_each            = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id           = akamai_appsec_configuration.default.config_id
  security_policy_id  = akamai_appsec_waf_protection.default[each.key].security_policy_id
  attack_group        = "CMD"
  attack_group_action = each.value.waf.attackGroups.commandInjection.action
  depends_on          = [ akamai_appsec_waf_protection.default ]
}

# Local File Inclusion.
resource "akamai_appsec_attack_group" "localFileInclusion" {
  for_each            = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id           = akamai_appsec_configuration.default.config_id
  security_policy_id  = akamai_appsec_waf_protection.default[each.key].security_policy_id
  attack_group        = "LFI"
  attack_group_action = each.value.waf.attackGroups.localFileInclusion.action
  depends_on          = [ akamai_appsec_waf_protection.default ]
}

# Remote File Inclusion.
resource "akamai_appsec_attack_group" "remoteFileInclusion" {
  for_each            = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id           = akamai_appsec_configuration.default.config_id
  security_policy_id  = akamai_appsec_waf_protection.default[each.key].security_policy_id
  attack_group        = "RFI"
  attack_group_action = each.value.waf.attackGroups.remoteFileInclusion.action
  depends_on          = [ akamai_appsec_waf_protection.default ]
}

# Web Platform Attack.
resource "akamai_appsec_attack_group" "webPlatformAttack" {
  for_each            = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id           = akamai_appsec_configuration.default.config_id
  security_policy_id  = akamai_appsec_waf_protection.default[each.key].security_policy_id
  attack_group        = "PLATFORM"
  attack_group_action = each.value.waf.attackGroups.webPlatformAttack.action
  depends_on          = [ akamai_appsec_waf_protection.default ]
}