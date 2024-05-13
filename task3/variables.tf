# ===========================================================
# Networks Configuration for Drizzle-Drizzle Games
# ===========================================================
variable "networks" {
  description = "Configuration for Drizzle Drizzle Gaming Networks"
  type        = map(map(string))
  default = {
    "drizzle-drizzle-games-network-eu" = {
      "vpc_name"                = "drizzle-drizzle-games-network-eu"
      "auto_create_subnetworks" = "false"

      "subnet_name"          = "drizzle-drizzle-games-hq"
      "subnet_location"      = "europe-west6"
      "subnet_ip_cidr_range" = "10.129.1.0/24"
    }

    "drizzle-drizzle-games-network-na" = {
      "vpc_name"                = "drizzle-drizzle-games-network-na"
      "auto_create_subnetworks" = "false"

      "subnet_name"          = "drizzle-drizzle-games-na-office"
      "subnet_location"      = "us-east1"
      "subnet_ip_cidr_range" = "172.16.35.0/24"
    }
    "drizzle-drizzle-games-network-sa" = {
      "vpc_name"                = "drizzle-drizzle-games-network-sa"
      "auto_create_subnetworks" = "false"

      "subnet_name"          = "drizzle-drizzle-games-sa-office"
      "subnet_location"      = "southamerica-east1"
      "subnet_ip_cidr_range" = "172.16.36.0/24"
    }
    "drizzle-drizzle-games-network-asia" = {
      "vpc_name"                = "drizzle-drizzle-games-network-asia"
      "auto_create_subnetworks" = "false"

      "subnet_name"          = "drizzle-drizzle-games-asia-office"
      "subnet_location"      = "asia-south2"
      "subnet_ip_cidr_range" = "192.168.44.0/24"
    }
  }
}

variable "vms" {
  type = map(map(string))
  default = {
    "eu-vm" = {
      "vm_name"           = "head-drizzler-in-charge"
      "vm_machine_type"   = "e2-standard-2"
      "vm_zone"           = "europe-west6-c"
      "vm_image"          = "projects/debian-cloud/global/images/debian-12-bookworm-v20240415"
      "vm_size"           = "10"
      "vm_auto_delete"    = "true"
      "vm_subnet"         = "projects/composed-garden-417100/regions/europe-west6/subnetworks/drizzle-drizzle-games-hq"
      "vm_startup_script" = true
      "vm_external_ip"    = "false"
      "http-server"       = true
    }

    "na-vm" = {
      "vm_name"           = "drizzler-001"
      "vm_machine_type"   = "e2-standard-2"
      "vm_zone"           = "us-east1-b"
      "vm_image"          = "projects/debian-cloud/global/images/debian-12-bookworm-v20240415"
      "vm_size"           = "10"
      "vm_auto_delete"    = "true"
      "vm_subnet"         = "projects/composed-garden-417100/regions/us-east1/subnetworks/drizzle-drizzle-games-na-office"
      "vm_startup_script" = false
      "vm_external_ip"    = "false"
      "http-server"       = false
    }

    "sa-vm" = {
      "vm_name"           = "drizzler-002"
      "vm_machine_type"   = "e2-standard-2"
      "vm_zone"           = "southamerica-east1-c"
      "vm_image"          = "projects/debian-cloud/global/images/debian-12-bookworm-v20240415"
      "vm_size"           = "10"
      "vm_auto_delete"    = "true"
      "vm_subnet"         = "projects/composed-garden-417100/regions/southamerica-east1/subnetworks/drizzle-drizzle-games-sa-office"
      "vm_startup_script" = false
      "vm_external_ip"    = "false"
      "http-server"       = false
    }

    "asia-vm" = {
      "vm_name"           = "drizzler-003"
      "vm_machine_type"   = "e2-standard-2"
      "vm_zone"           = "asia-south2-b"
      "vm_image"          = "projects/debian-cloud/global/images/debian-12-bookworm-v20240415"
      "vm_size"           = "10"
      "vm_auto_delete"    = "true"
      "vm_subnet"         = "projects/composed-garden-417100/regions/asia-south2/subnetworks/drizzle-drizzle-games-asia-office"
      "vm_startup_script" = false
      "vm_external_ip"    = "false"
      "http-server"       = false
    }
  }
}