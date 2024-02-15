# Definition of the Akamai Connected Cloud credentials.
provider "linode" {
  config_path    = pathexpand(fileexists(pathexpand(var.credentialsFilename)) ? var.credentialsFilename : "~/.aws/credentials")
  config_profile = fileexists(pathexpand(var.credentialsFilename)) ? "linode" : "default"
}