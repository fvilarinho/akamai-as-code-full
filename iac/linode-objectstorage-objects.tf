# Upload the pages.
resource "linode_object_storage_object" "pages" {
  for_each     = toset(fileset("../src/pages", "*.html"))
  cluster      = data.linode_object_storage_cluster.default.id
  bucket       = linode_object_storage_bucket.default.label
  key          = each.key
  content      = chomp(file("../src/pages/${each.key}"))
  content_type = "text/html"
  acl          = "public-read"
  access_key   = linode_object_storage_key.default.access_key
  secret_key   = linode_object_storage_key.default.secret_key
  depends_on   = [ linode_object_storage_key.default ]
}

# Upload the styles.
resource "linode_object_storage_object" "styles" {
  for_each     = toset(fileset("../src/pages/styles", "*"))
  cluster      = data.linode_object_storage_cluster.default.id
  bucket       = linode_object_storage_bucket.default.label
  key          = "styles/${each.key}"
  content      = chomp(file("../src/pages/styles/${each.key}"))
  content_type = "text/css"
  acl          = "public-read"
  access_key   = linode_object_storage_key.default.access_key
  secret_key   = linode_object_storage_key.default.secret_key
  depends_on   = [ linode_object_storage_key.default ]
}

# Upload the scripts.
resource "linode_object_storage_object" "scripts" {
  for_each     = toset(fileset("../src/pages/scripts", "*"))
  cluster      = data.linode_object_storage_cluster.default.id
  bucket       = linode_object_storage_bucket.default.label
  key          = "scripts/${each.key}"
  content      = chomp(file("../src/pages/scripts/${each.key}"))
  content_type = "text/javascript"
  acl          = "public-read"
  access_key   = linode_object_storage_key.default.access_key
  secret_key   = linode_object_storage_key.default.secret_key
  depends_on   = [ linode_object_storage_key.default ]
}

# Upload the images.
resource "linode_object_storage_object" "images" {
  for_each       = toset(fileset("../src/pages/images", "*"))
  cluster        = data.linode_object_storage_cluster.default.id
  bucket         = linode_object_storage_bucket.default.label
  key            = "images/${each.key}"
  content_base64 = filebase64("../src/pages/images/${each.key}")
  acl            = "public-read"
  access_key     = linode_object_storage_key.default.access_key
  secret_key     = linode_object_storage_key.default.secret_key
  depends_on     = [ linode_object_storage_key.default ]
}