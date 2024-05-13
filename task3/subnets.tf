# ===========================================================
# Subnetwork creation for Drizzle-Drizzle Games
# ===========================================================
resource "google_compute_subnetwork" "drizzle-drizzle-games-subnets" {
  for_each = var.networks

  name          = each.value["subnet_name"]
  network       = google_compute_network.drizzle-drizzle-games-networks[each.key].id
  region        = each.value["subnet_location"]
  ip_cidr_range = each.value["subnet_ip_cidr_range"]
}