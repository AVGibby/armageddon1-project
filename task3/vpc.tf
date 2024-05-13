// Network (VPC creation)
resource "google_compute_network" "drizzle-drizzle-games-networks" {
  for_each = var.networks

  name                    = each.value["vpc_name"]
  auto_create_subnetworks = each.value["auto_create_subnetworks"]
}