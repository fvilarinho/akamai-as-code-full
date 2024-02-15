# Definition of the security policies.
resource "akamai_appsec_security_policy" "default" {
  config_id              = akamai_appsec_configuration.default.config_id
  security_policy_name   = local.securitySettings.policies[0].id
  security_policy_prefix = "pol1"
  default_settings       = true
  depends_on             = [ akamai_appsec_configuration.default ]
}

resource "akamai_appsec_security_policy" "deny" {
  config_id              = akamai_appsec_configuration.default.config_id
  security_policy_name   = local.securitySettings.policies[1].id
  security_policy_prefix = "pol2"
  default_settings       = true
  depends_on             = [ akamai_appsec_configuration.default ]
}

# Definition of the security match targets.
resource "akamai_appsec_match_target" "default" {
  config_id    = akamai_appsec_configuration.default.config_id
  match_target = jsonencode(
    {
      "defaultFile" : "NO_MATCH",
      "filePaths" : [
        "/*"
      ],
      "hostnames" : local.securitySettings.policies[0].hostNames,
      "filePaths" : local.securitySettings.policies[0].filePaths,
      "isNegativeFileExtensionMatch" : false,
      "isNegativePathMatch" : false,
      "securityPolicy" : {
        "policyId" : akamai_appsec_security_policy.default.security_policy_id
      },
      "sequence" : 0,
      "type" : "website"
    }
  )

  depends_on = [ akamai_appsec_security_policy.default ]
}

resource "akamai_appsec_match_target" "deny" {
  config_id    = akamai_appsec_configuration.default.config_id
  match_target = jsonencode(
    {
      "defaultFile" : "NO_MATCH",
      "hostnames" : local.securitySettings.policies[1].hostNames,
      "filePaths" : local.securitySettings.policies[1].filePaths,
      "isNegativeFileExtensionMatch" : false,
      "isNegativePathMatch" : false,
      "securityPolicy" : {
        "policyId" : akamai_appsec_security_policy.deny.security_policy_id
      },
      "sequence" : 0,
      "type" : "website"
    }
  )

  depends_on = [ akamai_appsec_security_policy.deny ]
}
