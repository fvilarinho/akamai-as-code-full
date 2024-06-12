# Definition of security configuration.
resource "akamai_appsec_configuration" "default" {
  contract_id = local.generalSettings.contract
  group_id    = local.generalSettings.group
  name        = local.securitySettings.name
  description = local.securitySettings.description
  host_names  = local.securitySettings.hostnames
  depends_on  = [ akamai_property.default ]
}

# Fetches the security configuration metadata.
data "akamai_appsec_configuration" "default" {
  name       = akamai_appsec_configuration.default.name
  depends_on = [ akamai_appsec_configuration.default ]
}

# Activates the security configuration in staging network.
resource "akamai_appsec_activations" "staging" {
  config_id           = akamai_appsec_configuration.default.config_id
  version             = data.akamai_appsec_configuration.default.latest_version
  note                = local.securitySettings.notes
  notification_emails = [ local.generalSettings.email ]
  network             = "STAGING"
  depends_on          = [
    akamai_appsec_configuration.default,
    akamai_networklist_network_list.allowedIps,
    akamai_networklist_network_list.blockedIps,
    akamai_networklist_network_list.blockedGeos,
    akamai_appsec_security_policy.default,
    akamai_appsec_match_target.default,
    akamai_appsec_rate_protection.default,
    akamai_appsec_rate_policy.edgeRateLimits,
    akamai_appsec_rate_policy.originRateLimits,
    akamai_appsec_rate_policy_action.edgeRateLimits,
    akamai_appsec_rate_policy_action.originRateLimits,
    akamai_appsec_slowpost_protection.default,
    akamai_appsec_slow_post.default,
    akamai_appsec_ip_geo_protection.default,
    akamai_appsec_ip_geo.default,
    akamai_appsec_waf_protection.default,
    akamai_appsec_waf_mode.default,
    akamai_appsec_attack_group.webAttackTool,
    akamai_appsec_attack_group.webProtocolAttack,
    akamai_appsec_attack_group.webPlatformAttack,
    akamai_appsec_attack_group.webPolicyViolation,
    akamai_appsec_attack_group.sqlInjection,
    akamai_appsec_attack_group.xssInjection,
    akamai_appsec_attack_group.commandInjection,
    akamai_appsec_attack_group.remoteFileInclusion,
    akamai_appsec_attack_group.localFileInclusion,
    akamai_appsec_penalty_box.default,
    akamai_botman_bot_management_settings.default,
    akamai_botman_akamai_bot_category_action.academicOrResearchBots,
    akamai_botman_akamai_bot_category_action.automatedShoppingCartAndSniperBots,
    akamai_botman_akamai_bot_category_action.businessIntelligenceBots,
    akamai_botman_akamai_bot_category_action.ecommerceSearchEngineBots,
    akamai_botman_akamai_bot_category_action.enterpriseDataAggregatorBots,
    akamai_botman_akamai_bot_category_action.financialAccountAggregatorBots,
    akamai_botman_akamai_bot_category_action.mediaOrEntertainmentSearchBots,
    akamai_botman_akamai_bot_category_action.newsAggregatorBots,
    akamai_botman_akamai_bot_category_action.onlineAdvertisingBots,
    akamai_botman_akamai_bot_category_action.rssFeedReaderBots,
    akamai_botman_akamai_bot_category_action.searchEngineBots,
    akamai_botman_akamai_bot_category_action.seoAnalyticsOrMarketingBots,
    akamai_botman_akamai_bot_category_action.siteMonitoringAndWebDevelopmentBots,
    akamai_botman_akamai_bot_category_action.socialMediaOrBlogBots,
    akamai_botman_akamai_bot_category_action.webArchiverBots,
    akamai_botman_akamai_bot_category_action.webSearchEngineBots,
    akamai_botman_bot_detection_action.aggressiveWebCrawlers,
    akamai_botman_bot_detection_action.browserImpersonator,
    akamai_botman_bot_detection_action.clientDisabledJavascriptNoScriptTriggered,
    akamai_botman_bot_detection_action.cookieIntegrityFailed,
    akamai_botman_bot_detection_action.declaredBotsKeywordMatch,
    akamai_botman_bot_detection_action.developmentFrameworks,
    akamai_botman_bot_detection_action.headlessBrowsersAutomationTools,
    akamai_botman_bot_detection_action.httpLibraries,
    akamai_botman_bot_detection_action.impersonatorsOfKnownBots,
    akamai_botman_bot_detection_action.javascriptFingerprintAnomaly,
    akamai_botman_bot_detection_action.javascriptFingerprintNotReceived,
    akamai_botman_bot_detection_action.openSourceCrawlersScrapingPlatforms,
    akamai_botman_bot_detection_action.sessionValidation,
    akamai_botman_bot_detection_action.webScraperReputation,
    akamai_botman_bot_detection_action.webServicesLibraries
  ]
}

# Activates the security configuration in production network.
resource "akamai_appsec_activations" "production" {
  config_id           = akamai_appsec_configuration.default.config_id
  version             = data.akamai_appsec_configuration.default.latest_version
  note                = local.securitySettings.notes
  notification_emails = [ local.generalSettings.email ]
  network             = "PRODUCTION"
  depends_on          = [ akamai_appsec_activations.staging ]
}