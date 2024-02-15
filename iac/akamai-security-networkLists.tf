# Definition of the network lists.
resource "akamai_networklist_network_list" "allowedIps" {
  contract_id = local.generalSettings.contract
  group_id    = local.generalSettings.group
  name        = "${local.securitySettings.id}-allowedIps"
  type        = "IP"
  description = "Allowed IPs/Networks."
  list        = local.securitySettings.sharedResources.networkLists.allowedIps
  mode        = "REPLACE"
}

resource "akamai_networklist_network_list" "blockedIps" {
  contract_id = local.generalSettings.contract
  group_id    = local.generalSettings.group
  name        = "${local.securitySettings.id}-blockedIps"
  type        = "IP"
  description = "Blocked IPs/Networks."
  list        = local.securitySettings.sharedResources.networkLists.blockedIps
  mode        = "REPLACE"
}

resource "akamai_networklist_network_list" "blockedGeos" {
  contract_id = local.generalSettings.contract
  group_id    = local.generalSettings.group
  name        = "${local.securitySettings.id}-blockedGeos"
  type        = "GEO"
  description = "Blocked GEOs."
  list        = local.securitySettings.sharedResources.networkLists.blockedGeos
  mode        = "REPLACE"
}