# Definition of the CPS enrollment to add/modify/delete hostnames in a DV SAN certificate.
resource "akamai_cps_dv_enrollment" "default" {
  allow_duplicate_common_name           = false
  contract_id                           = local.generalSettings.contract
  acknowledge_pre_verification_warnings = true
  common_name                           = local.propertySettings.hostnames[0]
  sans                                  = local.propertySettings.hostnames
  secure_network                        = local.certificateSettings.networkType
  sni_only                              = true

  admin_contact {
    organization     = local.generalSettings.organization.id
    first_name       = local.generalSettings.organization.administratorContact.firstName
    last_name        = local.generalSettings.organization.administratorContact.lastName
    phone            = local.generalSettings.organization.administratorContact.phone
    email            = local.generalSettings.organization.administratorContact.email
    address_line_one = local.generalSettings.organization.address.line1
    address_line_two = local.generalSettings.organization.address.line2
    country_code     = local.generalSettings.organization.address.country
    city             = local.generalSettings.organization.address.city
    region           = local.generalSettings.organization.address.state
    postal_code      = local.generalSettings.organization.address.zipCode
  }

  tech_contact {
    organization     = local.generalSettings.organization.id
    first_name       = local.generalSettings.organization.technicalContact.firstName
    last_name        = local.generalSettings.organization.technicalContact.lastName
    phone            = local.generalSettings.organization.technicalContact.phone
    email            = local.generalSettings.organization.technicalContact.email
    address_line_one = local.generalSettings.organization.address.line1
    address_line_two = local.generalSettings.organization.address.line2
    country_code     = local.generalSettings.organization.address.country
    city             = local.generalSettings.organization.address.city
    region           = local.generalSettings.organization.address.state
    postal_code      = local.generalSettings.organization.address.zipCode
  }

  csr {
    country_code          = local.generalSettings.organization.address.country
    state                 = local.generalSettings.organization.address.state
    city                  = local.generalSettings.organization.address.city
    organization          = local.generalSettings.organization.id
    organizational_unit   = local.generalSettings.organization.id
  }

  network_configuration {
    clone_dns_names         = false
    disallowed_tls_versions = local.certificateSettings.disallowedTlsVersions
    geography               = local.certificateSettings.geography
    must_have_ciphers       = local.certificateSettings.ciphersList
    preferred_ciphers       = local.certificateSettings.ciphersList
    ocsp_stapling           = "on"
    quic_enabled            = true
  }

  signature_algorithm = local.certificateSettings.signatureAlgorithm

  organization {
    name             = local.generalSettings.organization.id
    phone            = local.generalSettings.organization.administratorContact.phone
    address_line_one = local.generalSettings.organization.address.line1
    address_line_two = local.generalSettings.organization.address.line2
    country_code     = local.generalSettings.organization.address.country
    region           = local.generalSettings.organization.address.state
    city             = local.generalSettings.organization.address.city
    postal_code      = local.generalSettings.organization.address.zipCode
  }
}

# Edge DNS entries for certificate validations.
resource "akamai_dns_record" "certificateValidations" {
  for_each   = { for challenge in akamai_cps_dv_enrollment.default.dns_challenges : challenge.domain => challenge }
  zone       = local.dnsSettings.id
  name       = each.value.full_path
  recordtype = "TXT"
  ttl        = local.dnsSettings.defaultTtl
  target     = [ each.value.response_body ]
  depends_on = [ akamai_cps_dv_enrollment.default ]
}

# Starts the certificate validations.
resource "akamai_cps_dv_validation" "default" {
  enrollment_id = akamai_cps_dv_enrollment.default.id
  sans          = akamai_cps_dv_enrollment.default.sans
  depends_on    = [ akamai_dns_record.certificateValidations ]
}