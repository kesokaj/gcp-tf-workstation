resource "google_service_account" "x" {
  project = var.project_id
  account_id   = "cloud-build-user-sa"
  display_name = "Cloud Build user"
}

resource "google_project_iam_member" "x" {
  project = var.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.x.email}"
}

resource "google_artifact_registry_repository" "x" {
  project       = var.project_id
  location      = var.region
  repository_id = "cloudworkstation"
  description   = "Cloud Workstations custom images"
  format        = "DOCKER"
}