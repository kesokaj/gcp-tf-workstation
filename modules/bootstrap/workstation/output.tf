output "base_workstation_url" {
  value = google_workstations_workstation.base.host
}

output "custom_workstation_url" {
  value = google_workstations_workstation.custom.host
}