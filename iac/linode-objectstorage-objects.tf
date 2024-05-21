# List all available content of the website.
locals {
  availablePages = fileset(local.generalSettings.contentDirectory, "**/*.html")
  availableStyles = fileset(local.generalSettings.contentDirectory, "**/styles/*")
  availableScripts = fileset(local.generalSettings.contentDirectory, "**/scripts/*")
  availableImages = fileset(local.generalSettings.contentDirectory, "**/images/*")
}

# Upload pages.
resource "linode_object_storage_object" "availablePages" {
  for_each       = { for file in local.availablePages : file => { bucket: element(split("/", file), 0) } }
  cluster        = data.linode_object_storage_cluster.default[each.value.bucket].id
  bucket         = linode_object_storage_bucket.default[each.value.bucket].label
  key            = replace(each.key, "${each.value.bucket}/", "")
  content_base64 = filebase64("${local.generalSettings.contentDirectory}/${each.key}")
  content_type   = "text/html"
  acl            = "public-read"
  access_key     = linode_object_storage_key.default[each.value.bucket].access_key
  secret_key     = linode_object_storage_key.default[each.value.bucket].secret_key
  depends_on     = [ linode_object_storage_key.default ]
}

# Upload styles.
resource "linode_object_storage_object" "availableStyles" {
  for_each       = { for file in local.availableStyles : file => { bucket: element(split("/", file), 0) } }
  cluster        = data.linode_object_storage_cluster.default[each.value.bucket].id
  bucket         = linode_object_storage_bucket.default[each.value.bucket].label
  key            = replace(each.key, "${each.value.bucket}/", "")
  content_base64 = filebase64("${local.generalSettings.contentDirectory}/${each.key}")
  content_type   = "text/css"
  acl            = "public-read"
  access_key     = linode_object_storage_key.default[each.value.bucket].access_key
  secret_key     = linode_object_storage_key.default[each.value.bucket].secret_key
  depends_on     = [ linode_object_storage_key.default ]
}

# Upload scripts.
resource "linode_object_storage_object" "availableScripts" {
  for_each       = { for file in local.availableScripts : file => { bucket: element(split("/", file), 0) } }
  cluster        = data.linode_object_storage_cluster.default[each.value.bucket].id
  bucket         = linode_object_storage_bucket.default[each.value.bucket].label
  key            = replace(each.key, "${each.value.bucket}/", "")
  content_base64 = filebase64("${local.generalSettings.contentDirectory}/${each.key}")
  content_type   = "text/javascript"
  acl            = "public-read"
  access_key     = linode_object_storage_key.default[each.value.bucket].access_key
  secret_key     = linode_object_storage_key.default[each.value.bucket].secret_key
  depends_on     = [ linode_object_storage_key.default ]
}

# Upload images.
resource "linode_object_storage_object" "availableImages" {
  for_each       = { for file in local.availableImages : file => { bucket: element(split("/", file), 0) } }
  cluster        = data.linode_object_storage_cluster.default[each.value.bucket].id
  bucket         = linode_object_storage_bucket.default[each.value.bucket].label
  key            = replace(each.key, "${each.value.bucket}/", "")
  content_base64 = filebase64("${local.generalSettings.contentDirectory}/${each.key}")
  acl            = "public-read"
  access_key     = linode_object_storage_key.default[each.value.bucket].access_key
  secret_key     = linode_object_storage_key.default[each.value.bucket].secret_key
  depends_on     = [ linode_object_storage_key.default ]
}