output "vpc" {
  value = google_compute_network.x.name
}

output "vpc_id" {
  value = google_compute_network.x.id
}

output "subnet" {
  value = values(google_compute_subnetwork.x)[*].name
}

output "subnet_id" {
  value = values(google_compute_subnetwork.x)[*].id
}