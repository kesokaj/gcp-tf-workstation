resource "google_service_account" "x" {
  project = var.project_id
  account_id   = "cloud-workstation-user-sa"
  display_name = "Cloud Workstations User"
}

resource "google_project_iam_member" "x" {
  project = var.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.x.email}"
}
resource "google_workstations_workstation_cluster" "x" {
  provider = google-beta
  workstation_cluster_id = "cluster-${var.alias}"
  network = var.network
  subnetwork = var.subnet_id
  location = var.region
  project = var.project_id
}

resource "google_workstations_workstation_config" "base" {
  provider = google-beta
  workstation_config_id = "base-config-${var.alias}"
  workstation_cluster_id = google_workstations_workstation_cluster.x.workstation_cluster_id
  location = var.region
  project = var.project_id

  idle_timeout = "3600s"
  running_timeout = "28800s"

  host {
    gce_instance {
      machine_type                = "e2-standard-4"
      boot_disk_size_gb           = 64
      disable_public_ip_addresses = true
      disable_ssh                 = false
      service_account             = google_service_account.x.email 
      shielded_instance_config {
        enable_secure_boot = true
        enable_vtpm        = true
      }

    }
  }

  container {
    image = "us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest"
  }

  persistent_directories {
    mount_path = "/home"
    gce_pd {
      size_gb        = 200
      fs_type        = "ext4"
      disk_type      = "pd-balanced"
      reclaim_policy = "DELETE"
    }
  }  
}

resource "google_workstations_workstation" "base" {
  provider = google-beta
  workstation_id = "base-workstation-${var.alias}"
  workstation_config_id  = google_workstations_workstation_config.base.workstation_config_id
  workstation_cluster_id = google_workstations_workstation_cluster.x.workstation_cluster_id
  location = var.region
  project = var.project_id
}

resource "google_workstations_workstation_config" "custom" {
  provider = google-beta
  workstation_config_id = "custom-config${var.alias}"
  workstation_cluster_id = google_workstations_workstation_cluster.x.workstation_cluster_id
  location = var.region
  project = var.project_id

  idle_timeout = "3600s"
  running_timeout = "28800s"

  host {
    gce_instance {
      machine_type                = "e2-standard-4"
      boot_disk_size_gb           = 64
      disable_public_ip_addresses = true
      disable_ssh                 = false
      service_account             = google_service_account.x.email 
      shielded_instance_config {
        enable_secure_boot = true
        enable_vtpm        = true
      }

    }
  }

  container {
    image = "${var.container_image}/custom-code-oss:latest"
  }

  persistent_directories {
    mount_path = "/home"
    gce_pd {
      size_gb        = 200
      fs_type        = "ext4"
      disk_type      = "pd-balanced"
      reclaim_policy = "DELETE"
    }
  }  
}

resource "google_workstations_workstation" "custom" {
  provider = google-beta
  workstation_id = "custom-workstation-${var.alias}"
  workstation_config_id  = google_workstations_workstation_config.custom.workstation_config_id
  workstation_cluster_id = google_workstations_workstation_cluster.x.workstation_cluster_id
  location = var.region
  project = var.project_id
}