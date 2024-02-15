# Fetch information from an object storage region.
data "linode_object_storage_cluster" "default" {
  id = local.propertySettings.origin.region
}

# Definition of the object storage bucket. This will be the origin hostname.
resource "linode_object_storage_bucket" "default" {
  cluster    = data.linode_object_storage_cluster.default.id
  label      = local.propertySettings.id
  acl        = "public-read"
  depends_on = [ data.linode_object_storage_cluster.default ]
}

# Definition of the object storage access key.
resource "linode_object_storage_key" "default" {
  label = local.propertySettings.id

  bucket_access {
    cluster     = data.linode_object_storage_cluster.default.id
    bucket_name = linode_object_storage_bucket.default.label
    permissions = "read_write"
  }

  depends_on = [ linode_object_storage_bucket.default ]
}