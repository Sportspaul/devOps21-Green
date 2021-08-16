provider "google" {
  credentials = file("C:/Users/phoglend/Downloads/devops21-green-6cf4691ccf58.json")

  project = "devops21-green"
  region  = "europe-north1"
  zone    = "europe-north1-a"
}

resource "google_compute_network" "terraform-network-1" {
  project                         = "devops21-green"
  name                            = "terraform-network-1"
  mtu                             = 1460
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
}

resource "google_compute_network" "terraform-network-2" {
  project                         = "devops21-green"
  name                            = "terraform-network-2"
  mtu                             = 1460
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
}

resource "google_compute_network_peering" "peering1" {
  name         = "peering1"
  network      = google_compute_network.terraform-network-1.id
  peer_network = google_compute_network.terraform-network-2.id
}

resource "google_compute_network_peering" "peering2" {
  name         = "peering2"
  network      = google_compute_network.terraform-network-2.id
  peer_network = google_compute_network.terraform-network-1.id
}