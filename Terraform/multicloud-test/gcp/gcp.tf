provider "google" {}

resource "google_compute_network" "gcp_net" {
  count = "${var.cloud_provider == "gcp" ? 1 : 0}"

  name                    = "test"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "gcp_subnets" {
  count = "${1 * (var.cloud_provider == "gcp" ? 1 : 0)}"

  name          = "testsubnet"
  ip_cidr_range = "${var.global_address_space}"
  region        = "${lookup(var.cloud_region, var.cloud_provider)}"
  network       = "${google_compute_network.gcp_net[0].self_link}"
} 

resource "google_compute_address" "gcp_int_addr" {
  count = "${var.cloud_provider == "gcp" ? 1 : 0}"

  name         = "test-int"
  region        = "${lookup(var.cloud_region, var.cloud_provider)}"
  subnetwork   = "${element(google_compute_subnetwork.gcp_subnets.*.self_link, count.index)}"
  address_type = "INTERNAL"
}

resource "google_compute_address" "gcp_ext_addr" {
  count = "${var.cloud_provider == "gcp" ? 1 : 0}"

  name = "test-ext"
  region        = "${lookup(var.cloud_region, var.cloud_provider)}"
}

// resource "google_compute_firewall" "gcp_custom_rules" {}

resource "google_compute_instance" "gcp_vm" {
  count = "${var.vm_count * (var.cloud_provider == "gcp" ? 1 : 0)}"

  name                      = "test-vm"
  machine_type              = "n1-standard-4"
  zone                      = "europe-west1-b"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts"
    }
  }

  network_interface {
    network    = "${google_compute_network.gcp_net[0].self_link}"
    network_ip = "${google_compute_address.gcp_int_addr[0].address}"
    subnetwork = "${google_compute_subnetwork.gcp_subnets[0].self_link}"

    access_config {
      nat_ip = "${google_compute_address.gcp_ext_addr[0].address}"
    }
  }
}
