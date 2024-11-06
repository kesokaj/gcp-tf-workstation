output "project_name" {
  value = module.base.project_name
}

output "project_id" {
  value = module.base.project_id
}

output "project_number" {
  value = module.base.project_number
}

output "alias" {
  value = module.base.alias
}

output "alias_id" {
  value = module.base.alias_id
}

output "docker_build_syntax" {
  value = "docker build -t ${module.cicd.repository_url} ."
}

output "docker_push_syntax" {
  value = "docker push ${module.cicd.repository_url}"
}

output "artifact_registry_login" {
  value = "gcloud auth configure-docker ${element(module.network.subnet, 0)}-docker.pkg.dev"
}