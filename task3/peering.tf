// PEERING: North America -n- Europe --------------------------
resource "google_compute_network_peering" "eu-to-na" {
  name         = "eu-to-na"
  network      = google_compute_network.drizzle-drizzle-games-networks["drizzle-drizzle-games-network-eu"].self_link
  peer_network = google_compute_network.drizzle-drizzle-games-networks["drizzle-drizzle-games-network-na"].self_link
}

resource "google_compute_network_peering" "na-to-eu" {
 name         = "na-to-eu"
 network      = google_compute_network.drizzle-drizzle-games-networks["drizzle-drizzle-games-network-na"].self_link
 peer_network = google_compute_network.drizzle-drizzle-games-networks["drizzle-drizzle-games-network-eu"].self_link
}

// PEERING: South America -n- Europe --------------------------
resource "google_compute_network_peering" "eu-to-sa" {
  name         = "eu-to-sa"
  network      = google_compute_network.drizzle-drizzle-games-networks["drizzle-drizzle-games-network-eu"].self_link
  peer_network = google_compute_network.drizzle-drizzle-games-networks["drizzle-drizzle-games-network-sa"].self_link
}

resource "google_compute_network_peering" "sa-to-eu" {
 name         = "sa-to-eu"
 network      = google_compute_network.drizzle-drizzle-games-networks["drizzle-drizzle-games-network-sa"].self_link
 peer_network = google_compute_network.drizzle-drizzle-games-networks["drizzle-drizzle-games-network-eu"].self_link
}
