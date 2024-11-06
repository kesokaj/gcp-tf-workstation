output "repository_url" {
  value = "${google_artifact_registry_repository.x.location}-docker.pkg.dev/${google_artifact_registry_repository.x.project}/${google_artifact_registry_repository.x.name}"
}