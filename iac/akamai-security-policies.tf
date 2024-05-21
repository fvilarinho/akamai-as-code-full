# Definition of security policies.
resource "akamai_appsec_security_policy" "default" {
  for_each               = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id              = akamai_appsec_configuration.default.config_id
  security_policy_name   = each.key
  security_policy_prefix = each.value.prefix
  default_settings       = true
  depends_on             = [ akamai_appsec_configuration.default ]
}

# Definition of security policies' match targets.
resource "akamai_appsec_match_target" "default" {
  for_each     = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id    = akamai_appsec_configuration.default.config_id
  match_target = jsonencode(
    {
      "defaultFile" : "NO_MATCH",
      "hostnames" : each.value.hostnames,
      "filePaths" : each.value.filePaths,
      "isNegativeFileExtensionMatch" : false,
      "isNegativePathMatch" : false,
      "securityPolicy" : {
        "policyId" : akamai_appsec_security_policy.default[each.key].security_policy_id
      },
      "sequence" : 0,
      "type" : "website"
    }
  )

  depends_on = [ akamai_appsec_security_policy.default ]
}