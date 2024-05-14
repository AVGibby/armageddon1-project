# resource "google_compute_firewall" "eu-allow-tcp-asia" {
#   name = "eu-allow-tcp-asia"
#   network = google_compute_network.drizzle-drizzle-games-networks["drizzle-drizzle-games-network-eu"].self_link
#   allow {
#     protocol = "tcp"
#     ports = ["80"]
#   }

#   source_ranges = ["192.168.44.0/24"] #["0.0.0.0/0"]
# #   depends_on = [google_compute_route.vpn-route1]
# }

# resource "google_compute_firewall" "asia-allow-tcp-eu" {
#   name = "asia-allow-tcp-eu"
#   network = google_compute_network.drizzle-drizzle-games-networks["drizzle-drizzle-games-network-asia"].self_link
#   allow {
#     protocol = "tcp"
#     ports = ["80"]
#   }

#   source_ranges = ["10.129.1.0/24"]
# #   depends_on = [google_compute_route.vpn-route1]
# }

# # =================================================

# resource "google_compute_firewall" "eu-allow-tcp-na" {
#   name = "eu-allow-tcp-na"
#   network = google_compute_network.drizzle-drizzle-games-networks["drizzle-drizzle-games-network-eu"].self_link
#   allow {
#     protocol = "tcp"
#     ports = ["80", "22"]
#   }

#   source_ranges = ["", "0.0.0.0/0"]
# #   depends_on = [google_compute_route.vpn-route1]
# }

# resource "google_compute_firewall" "na-allow-tcp-eu" {
#   name = "na-allow-tcp-eu"
#   network = google_compute_network.drizzle-drizzle-games-networks["drizzle-drizzle-games-network-na"].self_link
#   allow {
#     protocol = "tcp"
#     ports = ["80"]
#   }

#   source_ranges = ["", "0.0.0.0/0"]
# #   depends_on = [google_compute_route.vpn-route1]
# }

# # =================================================

resource "google_compute_firewall" "custom-vpc-tf-http" {
  name    = "http-allow"
  network = google_compute_network.drizzle-drizzle-games-networks["drizzle-drizzle-games-network-eu"].self_link

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["10.129.1.0/24", "172.16.35.0/24", "172.16.36.0/24", "192.168.44.0/24"]
}


resource "google_compute_firewall" "custom-vpc-tf-ssh-america" {
  name    = "ssh-allow"
  network = google_compute_network.drizzle-drizzle-games-networks["drizzle-drizzle-games-network-na"].self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["172.16.35.0/24", "172.16.36.0/24"]
}



resource "google_compute_firewall" "custom-vpc-tf" {
  name    = "nrule"
  network = google_compute_network.drizzle-drizzle-games-networks["drizzle-drizzle-games-network-na"].self_link

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }

  source_ranges = ["0.0.0.0/0", "35.235.240.0/20"]

  source_tags = ["web"]
}

resource "google_compute_firewall" "custom-vpc-tf-rdp" {
  name    = "rdp"
  network = google_compute_network.drizzle-drizzle-games-networks["drizzle-drizzle-games-network-asia"].self_link

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]
}
