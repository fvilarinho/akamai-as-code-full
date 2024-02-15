# Terraform definition
terraform {
  # Stores the provisioning state in Akamai Connected Cloud Object Storage.
  backend "s3" {
    bucket                      = "<bucket-id>"
    key                         = "akamai-demo.tfstate"
    region                      = "<region>"
    endpoint                    = "<region>.linodeobjects.com"
    skip_credentials_validation = true
    skip_region_validation      = true
  }

  # Defines the providers used by the provisioning.
  required_providers {
    akamai = {
      source = "akamai/akamai"
    }

    linode = {
      source = "linode/linode"
    }

    tls = {
      source = "hashicorp/tls"
    }
  }
}

# Loads all settings.
locals {
  generalSettings     = jsondecode(file(pathexpand(var.generalSettingsFilename)))
  certificateSettings = jsondecode(file(pathexpand(var.certificateSettingsFilename)))
  dnsSettings         = jsondecode(file(pathexpand(var.dnsSettingsFilename)))
  propertySettings    = jsondecode(file(pathexpand(var.propertySettingsFilename)))
  securitySettings    = jsondecode(file(pathexpand(var.securitySettingsFilename)))
}