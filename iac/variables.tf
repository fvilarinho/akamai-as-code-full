# Defines the Akamai Edge network to be used in the provisioning.
variable "network" {
  type    = string
  default = "STAGING"
}

# Defines the specific credentials filename.
variable "credentialsFilename" {
  type = string
}

# Defines the general settings filename.
variable "generalSettingsFilename" {
  type    = string
  default = "general/settings.json"
}

# Defines the certificate settings filename.
variable "certificateSettingsFilename" {
  type    = string
  default = "certificate/settings.json"
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