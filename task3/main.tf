// Network (VPC creation)
resource "google_compute_network" "drizzle-games-networks" {
  for_each = var.networks

  name                    = each.value["vpc_name"]
  auto_create_subnetworks = each.value["auto_create_subnetworks"]
}

// Subnet creation
resource "google_compute_subnetwork" "drizzle-games-subnets" {
  for_each = var.networks

  name          = each.value["subnet_name"]
  network       = google_compute_network.drizzle-games-networks[each.key].id
  region        = each.value["subnet_location"]
  ip_cidr_range = each.value["subnet_ip_cidr_range"]
}

// VM creation
resource "google_compute_instance" "drizzle-games-vm" {
  for_each = var.vms

  name         = each.value["vm_name"]
  machine_type = each.value["vm_machine_type"] #"e2-medium"
  zone         = each.value["vm_zone"]

  boot_disk {
    auto_delete = each.value["vm_auto_delete"]

    initialize_params {
      image = each.value["vm_image"]
      size  = each.value["vm_size"]
    }
  }

  network_interface {
    subnetwork = each.value["vm_subnet"]
  }

  metadata_startup_script = each.value["vm_startup_script"]
}

// PEERING: North America -n- Europe --------------------------
# -------------------------------------------------------------
resource "google_compute_network_peering" "eu-to-na" {
  name         = "eu-to-na"
  network      = google_compute_network.drizzle-games-networks["drizzle-games-network-eu"].self_link
  peer_network = google_compute_network.drizzle-games-networks["drizzle-games-network-na"].self_link
}
# -------------------------------------------------------------
resource "google_compute_network_peering" "na-to-eu" {
 name         = "na-to-eu"
 network      = google_compute_network.drizzle-games-networks["drizzle-games-network-na"].self_link
 peer_network = google_compute_network.drizzle-games-networks["drizzle-games-network-eu"].self_link
}
// PEERING: South America -n- Europe --------------------------
# -------------------------------------------------------------
resource "google_compute_network_peering" "eu-to-sa" {
  name         = "eu-to-sa"
  network      = google_compute_network.drizzle-games-networks["drizzle-games-network-eu"].self_link
  peer_network = google_compute_network.drizzle-games-networks["drizzle-games-network-sa"].self_link
}
# -------------------------------------------------------------
resource "google_compute_network_peering" "sa-to-eu" {
 name         = "sa-to-eu"
 network      = google_compute_network.drizzle-games-networks["drizzle-games-network-sa"].self_link
 peer_network = google_compute_network.drizzle-games-networks["drizzle-games-network-eu"].self_link
}
// Peering Compete --------------------------------------------
# -------------------------------------------------------------


// VPN: Asia -n- Europe ---------------------------------------
# -------------------------------------------------------------
resource "google_compute_vpn_tunnel" "tunnel1" {
  name          = "tunnel-1"
  peer_ip       = "15.0.0.120"
  shared_secret = "a secret message"

  target_vpn_gateway = google_compute_vpn_gateway.target_gateway.id

  depends_on = [
    google_compute_forwarding_rule.fr_esp,
    google_compute_forwarding_rule.fr_udp500,
    google_compute_forwarding_rule.fr_udp4500,
  ]

  labels = {
    foo = "bar"
  }
}

resource "google_compute_vpn_gateway" "target_gateway" {
  name    = "vpn-1"
  network = google_compute_network.network1.id
}

resource "google_compute_network" "network1" {
  name = "network-1"
}

resource "google_compute_address" "vpn_static_ip" {
  name = "vpn-static-ip"
}

resource "google_compute_forwarding_rule" "fr_esp" {
  name        = "fr-esp"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.vpn_static_ip.address
  target      = google_compute_vpn_gateway.target_gateway.id
}

resource "google_compute_forwarding_rule" "fr_udp500" {
  name        = "fr-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.vpn_static_ip.address
  target      = google_compute_vpn_gateway.target_gateway.id
}

resource "google_compute_forwarding_rule" "fr_udp4500" {
  name        = "fr-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.vpn_static_ip.address
  target      = google_compute_vpn_gateway.target_gateway.id
}

resource "google_compute_route" "route1" {
  name       = "route1"
  network    = google_compute_network.network1.name
  dest_range = "15.0.0.0/24"
  priority   = 1000

  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel1.id
}