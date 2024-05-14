#  resource "google_compute_address" "static_ip" {
#    for_each = var.ext-ips

#    name = each.value["vm_external_ip_name"]
#  }
 
resource "google_compute_address" "asia_static_ip" {
  name         = "asia-static-ip"
  region       = "asia-south2"
  address_type = "EXTERNAL"
}

 resource "google_compute_address" "eu_static_ip" {
  name         = "eu-static-ip"
  region       = "europe-west6"
  address_type = "EXTERNAL"
}