# resource "google_compute_address" "static" {
#   name   = "ipv4-address"
#   region = "asia-southeast1"
# }

resource "google_compute_network" "gibby-armageddon-vpc" {
  name                    = "gibby-armageddon-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "gibby-armageddon-vpc-asia" {
  name                     = "gibby-vpc-armageddon-asia"
  network                  = google_compute_network.gibby-armageddon-vpc.id
  ip_cidr_range            = "10.129.1.0/24"
  region                   = "asia-southeast1"
  private_ip_google_access = false

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_instance" "doomsday" {
  name         = "doomsday"
  zone         = "asia-southeast1-a"
  machine_type = "e2-medium"
  # allow_stopping_for_update = true
    
  tags = ["http-server"]

  network_interface {
    # network    = google_compute_network.gibby-armageddon-vpc.id
    subnetwork = google_compute_subnetwork.gibby-armageddon-vpc-asia.id

    access_config {
      # nat_ip = google_compute_address.static.address
    }
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = "20"
    }
  }

  metadata_startup_script = file("script2.txt")
}

resource "google_compute_firewall" "armageddon-firewall" {
  name          = "armageddon-firewall"
  network       = google_compute_network.gibby-armageddon-vpc.id
  source_ranges = ["0.0.0.0/0"]
  priority      = "1000"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}


/* 
additionally do I need to have the other firewall rule present for it to work
If I didn't config any firewall rules does the GCP dafualt still exist, deny all ingress | allow all egress

Prvate Google Access = On
Dynamic routing mode = regional
 */