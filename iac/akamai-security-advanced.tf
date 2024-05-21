# Definition of advanced security settings.

# Strip pragma headers.
locals {
  stripPragmaHeadersAction = (local.securitySettings.advanced.stripPragmaHeaders ? "{ \"action\": \"REMOVE\"}" : "{}")
}

resource "akamai_appsec_advanced_settings_pragma_header" "default" {
  config_id     = akamai_appsec_configuration.default.config_id
  pragma_header = local.stripPragmaHeadersAction
  depends_on    = [ akamai_appsec_configuration.default ]
}

# Evasive path match.
resource "akamai_appsec_advanced_settings_evasive_path_match" "default" {
  config_id         = akamai_appsec_configuration.default.config_id
  enable_path_match = local.securitySettings.advanced.evasivePathMatch
  depends_on        = [ akamai_appsec_configuration.default ]
}

# PII learning.
resource "akamai_appsec_advanced_settings_pii_learning" "default" {
  config_id           = akamai_appsec_configuration.default.config_id
  enable_pii_learning = local.securitySettings.advanced.piiLearning
  depends_on          = [ akamai_appsec_configuration.default ]
}

# Body inspection limit.
resource "akamai_appsec_advanced_settings_request_body" "default" {
  config_id                     = akamai_appsec_configuration.default.config_id
  request_body_inspection_limit = local.securitySettings.advanced.bodyInspectionLimit
  depends_on                    = [ akamai_appsec_configuration.default ]
}

# Logging.
resource "akamai_appsec_advanced_settings_logging" "default" {
  config_id  = akamai_appsec_configuration.default.config_id
  logging    = jsonencode(local.securitySettings.advanced.logging)
  depends_on = [ akamai_appsec_configuration.default ]
}

resource "akamai_appsec_advanced_settings_attack_payload_logging" "default" {
  config_id               = akamai_appsec_configuration.default.config_id
  attack_payload_logging = jsonencode(local.securitySettings.advanced.attackPayloadLogging)
  depends_on             = [ akamai_appsec_configuration.default ]
}

# SIEM integration.
resource "akamai_appsec_siem_settings" "default" {
  config_id               = akamai_appsec_configuration.default.config_id
  enable_siem             = local.securitySettings.advanced.siemLogging.enabled
  enable_botman_siem      = local.securitySettings.advanced.siemLogging.botManagerEvents
  enable_for_all_policies = true
  siem_id                 = local.securitySettings.advanced.siemLogging.version
}