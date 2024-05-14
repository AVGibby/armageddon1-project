// VM creation
resource "google_compute_instance" "drizzle-drizzle-games-vm" {
  for_each = var.vms

  depends_on = [
    google_compute_subnetwork.drizzle-drizzle-games-subnets
  ]
  

  name         = each.value["vm_name"]
  machine_type = each.value["vm_machine_type"]
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

    dynamic "access_config" {
      for_each = each.value.vm_external_ip ? [1] : [] # tests an interation's flag, "vm_external_ip", to see if true, if not, it will skip that iteration
      content {
        // This block will be included only if http-server is true
        # nat_ip = each.key == "eu-vm" ? google_compute_address.eu_static_ip.address : google_compute_address.asia_static_ip.address
      }
    }
  }

  tags = [each.value["http-server"] ? "http-server" : "non-http-server"]

  metadata = each.value["vm_startup_script"] ? {
    "startup-script" = file("startupscript.txt")
    } : {}
}