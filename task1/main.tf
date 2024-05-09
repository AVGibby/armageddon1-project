resource "google_storage_bucket" "gibby-public-bucket-tf" {
  name     = "gibby-public-bucket-tf"
  location = "us-east1"

  uniform_bucket_level_access = false

  public_access_prevention = "inherited"

  autoclass {
    enabled = true
  }

  website {
    main_page_suffix = index.html
    not_found_page = 404.html
  }
}

/* FILES */
# List of object filenames you want to upload and make public
locals {
  public_objects = [
    "57D35096-A54E-4A47-BC59-68353854E6F0.jpg",
    "A8D44B06-D2A6-4256-BC85-6B4A97F62AE5.jpg",
    "2179D21C-8818-4E3B-9A4C-9B5AF6D30A51.jpg",
    "EA1E67B9-2F40-4EA2-81CB-096D942F1B97.jpg",
    "index.html"
  ]
}

# Uploading and setting public access dynamically for each object
resource "google_storage_bucket_object" "myfiles" {
  for_each = toset(local.public_objects)
  name     = each.value
  source   = each.value
  bucket   = google_storage_bucket.gibby-public-bucket-tf.name
}

# Gives public access to each object uploaded
resource "google_storage_object_access_control" "public_access" {
  for_each = toset(local.public_objects)
  
  bucket   = google_storage_bucket.gibby-public-bucket-tf.name
  object   = google_storage_bucket_object.myfiles[each.key].name
  role     = "READER"
  entity   = "allUsers"
}
