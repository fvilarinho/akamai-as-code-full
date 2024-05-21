# Fetch information from an object storage region.
data "linode_object_storage_cluster" "default" {
  for_each = { for property in local.propertySettings.hostnames : property.name => property }
  id       = each.value.origin.region
}

# Definition of the object storage bucket. This will be the origin hostname.
resource "linode_object_storage_bucket" "default" {
  for_each   = { for property in local.propertySettings.hostnames : property.name => property }
  cluster    = data.linode_object_storage_cluster.default[each.key].id
  label      = "${local.propertySettings.name}-${each.value.origin.name}"
  acl        = "public-read"
  depends_on = [ data.linode_object_storage_cluster.default ]
}

# Definition of the object storage access key.
resource "linode_object_storage_key" "default" {
  for_each = { for property in local.propertySettings.hostnames : property.name => property }
  label    = "${local.propertySettings.name}-${each.value.origin.name}"

  bucket_access {
    cluster     = data.linode_object_storage_cluster.default[each.key].id
    bucket_name = linode_object_storage_bucket.default[each.key].label
    permissions = "read_write"
  }

  depends_on = [ linode_object_storage_bucket.default ]
}