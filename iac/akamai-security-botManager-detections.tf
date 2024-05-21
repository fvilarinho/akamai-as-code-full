# Definition of the Bot Management active and transparent detections.

# Declared Bots with Keyword Match.
resource "akamai_botman_bot_detection_action" "declaredBotsKeywordMatch" {
  for_each             = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id            = akamai_appsec_configuration.default.config_id
  security_policy_id   = akamai_appsec_security_policy.default[each.key].security_policy_id
  detection_id         = "074df68e-fb28-432a-ac6d-7cfb958425f1"
  bot_detection_action = jsonencode(each.value.botManager.detections.activeAndTransparent.declaredBotsKeywordMatch)
  depends_on           = [ akamai_botman_bot_management_settings.default ]
}

# Session validation.
resource "akamai_botman_bot_detection_action" "sessionValidation" {
  for_each             = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id            = akamai_appsec_configuration.default.config_id
  security_policy_id   = akamai_appsec_security_policy.default[each.key].security_policy_id
  detection_id         = "1bb748e2-b3ad-41db-85fa-c69e62be59dc"
  bot_detection_action = jsonencode(each.value.botManager.detections.activeAndTransparent.sessionValidation)
  depends_on           = [ akamai_botman_bot_management_settings.default ]
}

# Javascript Fingerprint Anomaly.
resource "akamai_botman_bot_detection_action" "javascriptFingerprintAnomaly" {
  for_each             = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id            = akamai_appsec_configuration.default.config_id
  security_policy_id   = akamai_appsec_security_policy.default[each.key].security_policy_id
  detection_id         = "393cba3d-656f-48f1-abe4-8dd5028c6871"
  bot_detection_action = jsonencode(each.value.botManager.detections.activeAndTransparent.javascriptFingerprintAnomaly)
  depends_on           = [ akamai_botman_bot_management_settings.default ]
}

# Cookie Integrity Failed.
resource "akamai_botman_bot_detection_action" "cookieIntegrityFailed" {
  for_each             = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id            = akamai_appsec_configuration.default.config_id
  security_policy_id   = akamai_appsec_security_policy.default[each.key].security_policy_id
  detection_id         = "4f1fd3ea-7072-4cd0-8d12-24f275e6c75d"
  bot_detection_action = jsonencode(each.value.botManager.detections.activeAndTransparent.cookieIntegrityFailed)
  depends_on           = [ akamai_botman_bot_management_settings.default ]
}

# HTTP Libraries.
resource "akamai_botman_bot_detection_action" "httpLibraries" {
  for_each             = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id            = akamai_appsec_configuration.default.config_id
  security_policy_id   = akamai_appsec_security_policy.default[each.key].security_policy_id
  detection_id         = "578dad32-024b-48b4-930c-db81831686f4"
  bot_detection_action = jsonencode(each.value.botManager.detections.activeAndTransparent.httpLibraries)
  depends_on           = [ akamai_botman_bot_management_settings.default ]
}

# Aggressive Web Crawlers.
resource "akamai_botman_bot_detection_action" "aggressiveWebCrawlers" {
  for_each             = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id            = akamai_appsec_configuration.default.config_id
  security_policy_id   = akamai_appsec_security_policy.default[each.key].security_policy_id
  detection_id         = "5bc041ad-c840-4202-9c2e-d7fc873dbeaf"
  bot_detection_action = jsonencode(each.value.botManager.detections.activeAndTransparent.aggressiveWebCrawlers)
  depends_on           = [ akamai_botman_bot_management_settings.default ]
}

# Opensource Crawlers and Scraping Platforms.
resource "akamai_botman_bot_detection_action" "openSourceCrawlersScrapingPlatforms" {
  for_each             = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id            = akamai_appsec_configuration.default.config_id
  security_policy_id   = akamai_appsec_security_policy.default[each.key].security_policy_id
  detection_id         = "601192ae-f5e2-4a29-8f75-a0bcd3584c2b"
  bot_detection_action = jsonencode(each.value.botManager.detections.activeAndTransparent.openSourceCrawlersScrapingPlatforms)
  depends_on           = [ akamai_botman_bot_management_settings.default ]
}

# Web Service Libraries.
resource "akamai_botman_bot_detection_action" "webServicesLibraries" {
  for_each             = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id            = akamai_appsec_configuration.default.config_id
  security_policy_id   = akamai_appsec_security_policy.default[each.key].security_policy_id
  detection_id         = "872ed6c2-514c-4055-9c44-9782b1c783bf"
  bot_detection_action = jsonencode(each.value.botManager.detections.activeAndTransparent.webServicesLibraries)
  depends_on           = [ akamai_botman_bot_management_settings.default ]
}

# Web Scraper Reputation.
resource "akamai_botman_bot_detection_action" "webScraperReputation" {
  for_each             = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id            = akamai_appsec_configuration.default.config_id
  security_policy_id   = akamai_appsec_security_policy.default[each.key].security_policy_id
  detection_id         = "9712ab32-83bb-43ab-a46d-4c2a5a42e7e2"
  bot_detection_action = jsonencode(each.value.botManager.detections.activeAndTransparent.webScraperReputation)
  depends_on           = [ akamai_botman_bot_management_settings.default ]
}

# Browser Impersonator.
resource "akamai_botman_bot_detection_action" "browserImpersonator" {
  for_each             = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id            = akamai_appsec_configuration.default.config_id
  security_policy_id   = akamai_appsec_security_policy.default[each.key].security_policy_id
  detection_id         = "a3b92f75-fa5d-436e-b066-426fc2919968"
  bot_detection_action = jsonencode(each.value.botManager.detections.activeAndTransparent.browserImpersonator)
  depends_on           = [ akamai_botman_bot_management_settings.default ]
}

# Headless Browsers and Automation Tools.
resource "akamai_botman_bot_detection_action" "headlessBrowsersAutomationTools" {
  for_each             = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id            = akamai_appsec_configuration.default.config_id
  security_policy_id   = akamai_appsec_security_policy.default[each.key].security_policy_id
  detection_id         = "b88cba13-4d11-46fe-a7e0-b47e78892dc4"
  bot_detection_action = jsonencode(each.value.botManager.detections.activeAndTransparent.headlessBrowsersAutomationTools)
  depends_on           = [ akamai_botman_bot_management_settings.default ]
}

# Client Disabled Javascript or No Script Triggered.
resource "akamai_botman_bot_detection_action" "clientDisabledJavascriptNoScriptTriggered" {
  for_each             = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id            = akamai_appsec_configuration.default.config_id
  security_policy_id   = akamai_appsec_security_policy.default[each.key].security_policy_id
  detection_id         = "c5623efa-f326-41d1-9601-a2d201bedf63"
  bot_detection_action = jsonencode(each.value.botManager.detections.activeAndTransparent.clientDisabledJavascriptNoScriptTriggered)
  depends_on           = [ akamai_botman_bot_management_settings.default ]
}

# Javascript Fingerprint Not Received.
resource "akamai_botman_bot_detection_action" "javascriptFingerprintNotReceived" {
  for_each             = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id            = akamai_appsec_configuration.default.config_id
  security_policy_id   = akamai_appsec_security_policy.default[each.key].security_policy_id
  detection_id         = "c7f70f75-e3e2-4181-8ef8-30afb6576147"
  bot_detection_action = jsonencode(each.value.botManager.detections.activeAndTransparent.javascriptFingerprintNotReceived)
  depends_on           = [ akamai_botman_bot_management_settings.default ]
}

# Development Frameworks.
resource "akamai_botman_bot_detection_action" "developmentFrameworks" {
  for_each             = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id            = akamai_appsec_configuration.default.config_id
  security_policy_id   = akamai_appsec_security_policy.default[each.key].security_policy_id
  detection_id         = "da005ad3-8bbb-43c8-a783-d97d1fb71ad2"
  bot_detection_action = jsonencode(each.value.botManager.detections.activeAndTransparent.developmentFrameworks)
  depends_on           = [ akamai_botman_bot_management_settings.default ]
}

# Impersonator of Known Bots.
resource "akamai_botman_bot_detection_action" "impersonatorsOfKnownBots" {
  for_each             = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id            = akamai_appsec_configuration.default.config_id
  security_policy_id   = akamai_appsec_security_policy.default[each.key].security_policy_id
  detection_id         = "fda1ffb9-ef46-4570-929c-7449c0c750f8"
  bot_detection_action = jsonencode(each.value.botManager.detections.activeAndTransparent.impersonatorsOfKnownBots)
  depends_on           = [ akamai_botman_bot_management_settings.default ]
}