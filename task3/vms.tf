// VM creation
resource "google_compute_instance" "drizzle-drizzle-games-vm" {
  for_each = var.vms

  depends_on = [google_compute_subnetwork.drizzle-drizzle-games-subnets]

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
      for_each = each.value.http-server ? [1] : []
      content {
        // This block will be included only if http-server is true
      }
    }
  }

  tags = [each.value["http-server"] ? "http-server" : "non-http-server"]

  metadata = each.value["vm_startup_script"] ? {
    "startup-script" = file("startupscript.txt")
    } : {}
}