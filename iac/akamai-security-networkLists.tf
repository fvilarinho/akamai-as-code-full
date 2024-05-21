# Definition of allowed IPs network list.
resource "akamai_networklist_network_list" "allowedIps" {
  contract_id = local.generalSettings.contract
  group_id    = local.generalSettings.group
  name        = "${local.securitySettings.name}-allowedIps"
  type        = "IP"
  description = "Allowed IPs/Networks."
  list        = local.securitySettings.sharedResources.networkLists.allowedIps
  mode        = "REPLACE"
}

# Definition of blocked IPs network list.
resource "akamai_networklist_network_list" "blockedIps" {
  contract_id = local.generalSettings.contract
  group_id    = local.generalSettings.group
  name        = "${local.securitySettings.name}-blockedIps"
  type        = "IP"
  description = "Blocked IPs/Networks."
  list        = local.securitySettings.sharedResources.networkLists.blockedIps
  mode        = "REPLACE"
}

# Definition of blocked GEOs network list.
resource "akamai_networklist_network_list" "blockedGeos" {
  contract_id = local.generalSettings.contract
  group_id    = local.generalSettings.group
  name        = "${local.securitySettings.name}-blockedGeos"
  type        = "GEO"
  description = "Blocked GEOs."
  list        = local.securitySettings.sharedResources.networkLists.blockedGeos
  mode        = "REPLACE"
}

# Definition of TOR network list.
data "akamai_networklist_network_lists" "torNetwork" {
  name = "Tor Akamai Network List"
}