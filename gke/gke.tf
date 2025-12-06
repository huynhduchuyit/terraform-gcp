resource "google_container_cluster" "main" {
  name                     = "${var.project_name}-${var.env}-gke"
  location                 = var.region
  node_locations           = ["${var.region}-a"]
  network                  = data.google_compute_network.main.self_link
  subnetwork               = data.google_compute_subnetwork.main.self_link
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "14.169.149.183/32"
    }
  }
}

resource "google_container_node_pool" "main" {
  name       = "${var.project_name}-${var.env}-primary"
  cluster    = google_container_cluster.main.name
  location   = var.region
  node_count = 2

  autoscaling {
    min_node_count = 2
    max_node_count = 5
  }

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 30
  }
}
