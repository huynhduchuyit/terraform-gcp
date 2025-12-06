resource "google_compute_instance" "main" {
  name         = "${var.project_name}-${var.env}-vm"
  machine_type = "e2-small"
  zone         = "${var.region}-a"

  tags = ["${var.project_name}-${var.env}-fw"]

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2404-lts-amd64"
      size  = 30
      type  = "pd-ssd"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "${var.os_user}:${tls_private_key.main.public_key_openssh}"
  }

  labels = {
    project = var.project_name
    env     = var.env
  }

  depends_on = [
    google_compute_firewall.main,
    tls_private_key.main
  ]
}

resource "google_compute_firewall" "main" {
  name    = "${var.project_name}-${var.env}-fw"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["${var.project_name}-${var.env}-fw"]
}
