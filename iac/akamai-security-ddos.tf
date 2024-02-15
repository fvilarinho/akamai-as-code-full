# Definition of DDoS rate limits protection.
resource "akamai_appsec_rate_protection" "default" {
  config_id          = akamai_appsec_configuration.default.config_id
  security_policy_id = akamai_appsec_security_policy.default.security_policy_id
  enabled            = local.securitySettings.policies[0].ddos.rateLimits.enabled
  depends_on         = [ akamai_appsec_security_policy.default ]
}

resource "akamai_appsec_rate_protection" "deny" {
  config_id          = akamai_appsec_configuration.default.config_id
  security_policy_id = akamai_appsec_security_policy.default.security_policy_id
  enabled            = local.securitySettings.policies[1].ddos.rateLimits.enabled
  depends_on         = [ akamai_appsec_security_policy.deny ]
}

resource "akamai_appsec_rate_policy_action" "defaultEdgeRateLimits" {
  config_id          = akamai_appsec_configuration.default.config_id
  security_policy_id = akamai_appsec_security_policy.default.security_policy_id
  rate_policy_id     = akamai_appsec_rate_policy.edgeRateLimits.rate_policy_id
  ipv4_action        = local.securitySettings.policies[0].ddos.rateLimits.edge.action
  ipv6_action        = local.securitySettings.policies[0].ddos.rateLimits.edge.action
  depends_on         = [
    akamai_appsec_rate_protection.default,
    akamai_appsec_rate_policy.edgeRateLimits
  ]
}

resource "akamai_appsec_rate_policy_action" "defaultOriginRateLimits" {
  config_id          = akamai_appsec_configuration.default.config_id
  security_policy_id = akamai_appsec_security_policy.default.security_policy_id
  rate_policy_id     = akamai_appsec_rate_policy.originRateLimits.rate_policy_id
  ipv4_action        = local.securitySettings.policies[0].ddos.rateLimits.origin.action
  ipv6_action        = local.securitySettings.policies[0].ddos.rateLimits.origin.action
  depends_on         = [
    akamai_appsec_rate_protection.default,
    akamai_appsec_rate_policy.originRateLimits
  ]
}

# Definition of DDoS slowpost protection.
resource "akamai_appsec_slowpost_protection" "default" {
  config_id          = akamai_appsec_configuration.default.config_id
  security_policy_id = akamai_appsec_security_policy.default.security_policy_id
  enabled            = local.securitySettings.policies[0].ddos.slowPost.enabled
  depends_on         = [ akamai_appsec_security_policy.default ]
}

resource "akamai_appsec_slowpost_protection" "deny" {
  config_id          = akamai_appsec_configuration.default.config_id
  security_policy_id = akamai_appsec_security_policy.deny.security_policy_id
  enabled            = local.securitySettings.policies[1].ddos.slowPost.enabled
  depends_on         = [ akamai_appsec_security_policy.deny ]
}

resource "akamai_appsec_slow_post" "default" {
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default.security_policy_id
  slow_rate_threshold_rate   = local.securitySettings.policies[0].ddos.slowPost.threshold.rate
  slow_rate_threshold_period = local.securitySettings.policies[0].ddos.slowPost.threshold.period
  slow_rate_action           = local.securitySettings.policies[0].ddos.slowPost.action
  depends_on                 = [ akamai_appsec_slowpost_protection.default ]
}

resource "akamai_appsec_slow_post" "deny" {
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.deny.security_policy_id
  slow_rate_threshold_rate   = local.securitySettings.policies[1].ddos.slowPost.threshold.rate
  slow_rate_threshold_period = local.securitySettings.policies[1].ddos.slowPost.threshold.period
  slow_rate_action           = local.securitySettings.policies[1].ddos.slowPost.action
  depends_on                 = [ akamai_appsec_slowpost_protection.deny ]
}