# Definition of Bot Manager categories (Akamai).

# Site Monitoring and Web Development bots.
resource "akamai_botman_akamai_bot_category_action" "siteMonitoringAndWebDevelopmentBots" {
  for_each                   = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default[each.key].security_policy_id
  category_id                = "07782c03-8d21-4491-9078-b83514e6508f"
  akamai_bot_category_action = jsonencode(each.value.botManager.detections.akamai.siteMonitoringAndWebDevelopmentBots)
  depends_on                 = [ akamai_botman_bot_management_settings.default ]
}

# Academic or Research bots.
resource "akamai_botman_akamai_bot_category_action" "academicOrResearchBots" {
  for_each                   = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default[each.key].security_policy_id
  category_id                = "0c508e1d-73a4-4366-9e48-3c4a080f1c5d"
  akamai_bot_category_action = jsonencode(each.value.botManager.detections.akamai.academicOrResearchBots)
  depends_on                 = [ akamai_botman_bot_management_settings.default ]
}

# Search Engine bots.
resource "akamai_botman_akamai_bot_category_action" "searchEngineBots" {
  for_each                   = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default[each.key].security_policy_id
  category_id                = "2f169206-f32c-48f7-b281-d534cf1ceeb3"
  akamai_bot_category_action = jsonencode(each.value.botManager.detections.akamai.searchEngineBots)
  depends_on                 = [ akamai_botman_bot_management_settings.default ]
}

# Online Advertising bots.
resource "akamai_botman_akamai_bot_category_action" "onlineAdvertisingBots" {
  for_each                   = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default[each.key].security_policy_id
  category_id                = "36b27e0c-76fc-44a4-b913-c598c5af8bba"
  akamai_bot_category_action = jsonencode(each.value.botManager.detections.akamai.onlineAdvertisingBots)
  depends_on                 = [ akamai_botman_bot_management_settings.default ]
}

# e-Commerce Search Engine bots.
resource "akamai_botman_akamai_bot_category_action" "ecommerceSearchEngineBots" {
  for_each                   = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default[each.key].security_policy_id
  category_id                = "47bcfb70-f3f5-458b-8f7c-1773b14bc6a4"
  akamai_bot_category_action = jsonencode(each.value.botManager.detections.akamai.ecommerceSearchEngineBots)
  depends_on                 = [ akamai_botman_bot_management_settings.default ]
}

# Web Search Engine bots.
resource "akamai_botman_akamai_bot_category_action" "webSearchEngineBots" {
  for_each                   = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default[each.key].security_policy_id
  category_id                = "4e14219f-6568-4c9d-9bd8-b29ca2afc422"
  akamai_bot_category_action = jsonencode(each.value.botManager.detections.akamai.webSearchEngineBots)
  depends_on                 = [ akamai_botman_bot_management_settings.default ]
}

# Enterprise Data Aggregator bots.
resource "akamai_botman_akamai_bot_category_action" "enterpriseDataAggregatorBots" {
  for_each                   = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default[each.key].security_policy_id
  category_id                = "50395ad2-2673-41a4-b317-9b70742fd40f"
  akamai_bot_category_action = jsonencode(each.value.botManager.detections.akamai.enterpriseDataAggregatorBots)
  depends_on                 = [ akamai_botman_bot_management_settings.default ]
}

# Social Media or Blogs bots.
resource "akamai_botman_akamai_bot_category_action" "socialMediaOrBlogBots" {
  for_each                   = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default[each.key].security_policy_id
  category_id                = "7035af8d-148c-429a-89da-de41e68c72d8"
  akamai_bot_category_action = jsonencode(each.value.botManager.detections.akamai.socialMediaOrBlogBots)
  depends_on                 = [ akamai_botman_bot_management_settings.default ]
}

# Automated Shopping Cart and Sniper bots.
resource "akamai_botman_akamai_bot_category_action" "automatedShoppingCartAndSniperBots" {
  for_each                   = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default[each.key].security_policy_id
  category_id                = "75493431-b41a-492c-8324-f12158783ce1"
  akamai_bot_category_action = jsonencode(each.value.botManager.detections.akamai.automatedShoppingCartAndSniperBots)
  depends_on                 = [ akamai_botman_bot_management_settings.default ]
}

# Web Archiver bots.
resource "akamai_botman_akamai_bot_category_action" "webArchiverBots" {
  for_each                   = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default[each.key].security_policy_id
  category_id                = "831ef84a-c2bb-4b0d-b90d-bcd16793b830"
  akamai_bot_category_action = jsonencode(each.value.botManager.detections.akamai.webArchiverBots)
  depends_on                 = [ akamai_botman_bot_management_settings.default ]
}

# Business Intelligence bots.
resource "akamai_botman_akamai_bot_category_action" "businessIntelligenceBots" {
  for_each                   = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default[each.key].security_policy_id
  category_id                = "8a70d29c-a491-4583-9768-7deea2f379c1"
  akamai_bot_category_action = jsonencode(each.value.botManager.detections.akamai.businessIntelligenceBots)
  depends_on                 = [ akamai_botman_bot_management_settings.default ]
}

# News Aggregator bots.
resource "akamai_botman_akamai_bot_category_action" "newsAggregatorBots" {
  for_each                   = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default[each.key].security_policy_id
  category_id                = "ade03247-6519-4591-8458-9b7347004b63"
  akamai_bot_category_action = jsonencode(each.value.botManager.detections.akamai.newsAggregatorBots)
  depends_on                 = [ akamai_botman_bot_management_settings.default ]
}

# RSS Feed Reader bots.
resource "akamai_botman_akamai_bot_category_action" "rssFeedReaderBots" {
  for_each                   = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default[each.key].security_policy_id
  category_id                = "b58c9929-9fd0-45f7-86f4-1d6259285c3c"
  akamai_bot_category_action = jsonencode(each.value.botManager.detections.akamai.rssFeedReaderBots)
  depends_on                 = [ akamai_botman_bot_management_settings.default ]
}

# Financial Account Aggregator bots.
resource "akamai_botman_akamai_bot_category_action" "financialAccountAggregatorBots" {
  for_each                   = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default[each.key].security_policy_id
  category_id                = "c6692e03-d3a8-49b0-9566-5003eeaddbc1"
  akamai_bot_category_action = jsonencode(each.value.botManager.detections.akamai.financialAccountAggregatorBots)
  depends_on                 = [ akamai_botman_bot_management_settings.default ]
}

# Media or Entertainment Search bots.
resource "akamai_botman_akamai_bot_category_action" "mediaOrEntertainmentSearchBots" {
  for_each                   = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default[each.key].security_policy_id
  category_id                = "dff258d5-b1ad-4bbb-b1d1-cf8e700e5bba"
  akamai_bot_category_action = jsonencode(each.value.botManager.detections.akamai.mediaOrEntertainmentSearchBots)
  depends_on                 = [ akamai_botman_bot_management_settings.default ]
}

# SEO Analytics or Marketing bots.
resource "akamai_botman_akamai_bot_category_action" "seoAnalyticsOrMarketingBots" {
  for_each                   = { for policy in local.securitySettings.policies : policy.name => policy }
  config_id                  = akamai_appsec_configuration.default.config_id
  security_policy_id         = akamai_appsec_security_policy.default[each.key].security_policy_id
  category_id                = "f7558c03-9033-46ce-bbda-10eeda62a5d4"
  akamai_bot_category_action = jsonencode(each.value.botManager.detections.akamai.seoAnalyticsOrMarketingBots)
  depends_on                 = [ akamai_botman_bot_management_settings.default ]
}