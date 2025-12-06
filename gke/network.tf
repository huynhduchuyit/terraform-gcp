data "google_compute_network" "main" {
  name = "${var.project_name}-${var.env}-vpc"
}

data "google_compute_subnetwork" "main" {
  name = "${var.project_name}-${var.env}-subnet"
}
