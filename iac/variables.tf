# Defines the general settings filename.
variable "generalSettingsFilename" {
  type    = string
  default = "general/settings.json"
}

# Defines the DNS settings filename.
variable "dnsSettingsFilename" {
  type    = string
  default = "dns/settings.json"
}

# Defines the property (CDN) settings filename.
variable "propertySettingsFilename" {
  type    = string
  default = "property/settings.json"
}

# Defines the security settings filename.
variable "securitySettingsFilename" {
  type    = string
  default = "security/settings.json"
}

# Linode API token,
variable "linodeToken" {
  type = string
}

# EdgeGrid API account key.
variable "edgeGridAccountKey" {
  type = string
}

# EdgeGrid API host.
variable "edgeGridHost" {
  type = string
}

# EdgeGrid API access token.
variable "edgeGridAccessToken" {
  type = string
}

# EdgeGrid API client token.
variable "edgeGridClientToken" {
  type = string
}

# EdgeGrid API client secret.
variable "edgeGridClientSecret" {
  type = string
}

# Defines the Akamai Edge network to be used in the provisioning.
variable "network" {
  type    = string
  default = "STAGING"
}