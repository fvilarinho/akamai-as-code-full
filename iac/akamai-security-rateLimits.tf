# Definition of the DDoS rate limits.
resource "akamai_appsec_rate_policy" "edgeRateLimits" {
  config_id   = akamai_appsec_configuration.default.config_id
  rate_policy = jsonencode(local.securitySettings.sharedResources.rateLimits.edge)
  depends_on  = [ akamai_appsec_configuration.default ]
}

resource "akamai_appsec_rate_policy" "originRateLimits" {
  config_id   = akamai_appsec_configuration.default.config_id
  rate_policy = jsonencode(local.securitySettings.sharedResources.rateLimits.origin)
  depends_on  = [ akamai_appsec_configuration.default ]
}