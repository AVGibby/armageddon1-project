#  VPN: Asia to Europe ----------------------------------------
# -------------------------------------------------------------
resource "google_compute_vpn_tunnel" "asia-tunnel-to-eu" {
  name                    = "asia-tunnel-to-eu"
  peer_ip                 = google_compute_address.eu_static_ip.address # Remote address
  shared_secret           = "asecretmessage123"
  ike_version             = 2
  target_vpn_gateway      = google_compute_vpn_gateway.asia_gateway.id # Local Gateway
  
  local_traffic_selector  = ["192.168.44.0/24"]
  remote_traffic_selector = ["10.129.1.0/24"]
  
  depends_on = [
    google_compute_forwarding_rule.fr_esp_asia,
    google_compute_forwarding_rule.fr_udp500_asia,
    google_compute_forwarding_rule.fr_udp4500_asia,
  ]

  labels = {
    foo = "bar"
  }
}

# resource "google_compute_route" "route1" {
#   name       = "route1"
#   network    = google_compute_network.network1.name
#   dest_range = "15.0.0.0/24"
#   priority   = 1000

#   next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel1.id
# }

resource "google_compute_vpn_gateway" "asia_gateway" {
  name    = "asia-gateway"
  network = google_compute_network.drizzle-drizzle-games-networks["drizzle-drizzle-games-network-asia"].self_link # Local Network
  region  = "asia-south2"
}

resource "google_compute_forwarding_rule" "fr_esp_asia" {
  name        = "fr-esp-asia"
  region = "asia-south2"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.asia_static_ip.address
  target      = google_compute_vpn_gateway.asia_gateway.id
}

resource "google_compute_forwarding_rule" "fr_udp500_asia" {
  name        = "fr-udp500-asia"
  region = "asia-south2"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.asia_static_ip.address
  target      = google_compute_vpn_gateway.asia_gateway.id
}

resource "google_compute_forwarding_rule" "fr_udp4500_asia" {
  name        = "fr-udp4500-asia"
  region = "asia-south2"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.asia_static_ip.address
  target      = google_compute_vpn_gateway.asia_gateway.id
}