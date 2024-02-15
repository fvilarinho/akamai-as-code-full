# Definition of the Akamai EdgeGrid credentials.
provider "akamai" {
  edgerc         = pathexpand(fileexists(pathexpand(var.credentialsFilename)) ? var.credentialsFilename : "~/.edgerc")
  config_section = fileexists(pathexpand(var.credentialsFilename)) ? "edgegrid" : "default"
}