provider "google" {
  project = "iaas-provision-236417"
  region = "asia-east1"
  zone = "asia-east1-a"
}

resource "google_compute_instance" "vm_instance" {
  count = 3
  name = "terraform-${count.index}"
  machine_type = "n1-standard-2"

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-lts"
      size = "30"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config = {
    }
  }
}
resource "google_compute_firewall" "http" {
  name    = "default-firewall-http-1"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags   = ["default-firewall-http"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "https" {
  name    = "default-firewall-https-1"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
}
resource "google_compute_firewall" "ssh" {
  name    = "default-firewall-ssh-1"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

