# Definition of DDoS rate limits protection.
resource "akamai_appsec_rate_protection" "default" {
  for_each           = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id          = akamai_appsec_configuration.default.config_id
  security_policy_id = akamai_appsec_security_policy.default[each.key].security_policy_id
  enabled            = each.value.ddos.rateLimits.enabled
  depends_on         = [ akamai_appsec_security_policy.default ]
}

# Definition of DDoS rate limits rules (Client to Edge).
resource "akamai_appsec_rate_policy_action" "edgeRateLimits" {
  for_each           = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id          = akamai_appsec_configuration.default.config_id
  security_policy_id = akamai_appsec_security_policy.default[each.key].security_policy_id
  rate_policy_id     = akamai_appsec_rate_policy.edgeRateLimits.rate_policy_id
  ipv4_action        = each.value.ddos.rateLimits.edge.action
  ipv6_action        = each.value.ddos.rateLimits.edge.action
  depends_on         = [
    akamai_appsec_rate_protection.default,
    akamai_appsec_rate_policy.edgeRateLimits
  ]
}

# Definition of DDoS rate limits rules (Edge to Origin).
resource "akamai_appsec_rate_policy_action" "originRateLimits" {
  for_each           = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id          = akamai_appsec_configuration.default.config_id
  security_policy_id = akamai_appsec_security_policy.default[each.key].security_policy_id
  rate_policy_id     = akamai_appsec_rate_policy.originRateLimits.rate_policy_id
  ipv4_action        = each.value.ddos.rateLimits.origin.action
  ipv6_action        = each.value.ddos.rateLimits.origin.action
  depends_on         = [
    akamai_appsec_rate_protection.default,
    akamai_appsec_rate_policy.originRateLimits
  ]
}

# Definition of DDoS slowpost protection.
resource "akamai_appsec_slowpost_protection" "default" {
  for_each           = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id          = akamai_appsec_configuration.default.config_id
  security_policy_id = akamai_appsec_security_policy.default[each.key].security_policy_id
  enabled            = each.value.ddos.slowPost.enabled
  depends_on         = [ akamai_appsec_security_policy.default ]
}

# Definition of DDoS slowpost rules.
resource "akamai_appsec_slow_post" "default" {
  for_each                   = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default[each.key].security_policy_id
  slow_rate_threshold_rate   = each.value.ddos.slowPost.threshold.rate
  slow_rate_threshold_period = each.value.ddos.slowPost.threshold.period
  slow_rate_action           = each.value.ddos.slowPost.action
  depends_on                 = [ akamai_appsec_slowpost_protection.default ]
}