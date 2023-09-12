resource "google_cloud_run_v2_service" "public_service" {
  name     = var.public_service_name
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {

      image = "gcr.io/cloudrun/hello"

      resources {
        limits = {
          cpu    = "1"
          memory = "128Mi"
        }
        startup_cpu_boost = true
      }
    }

    max_instance_request_concurrency = 50

    scaling {
      min_instance_count = 1
      max_instance_count = 10
    }
  }

  traffic {
    type     = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent  = 100
    revision = "LATEST"
  }

}

resource "google_cloud_run_v2_service_iam_binding" "public_service_binding" {
  project  = var.project_id
  location = var.public_service_location
  name     = google_cloud_run_v2_service.public_service.name
  role     = "roles/run.invoker"
  members = [
    "allUsers",
  ]
}

resource "google_cloud_run_v2_service" "private_service" {
  name     = var.private_service_name
  location = var.private_service_location
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  template {
    containers {

      image = "gcr.io/cloudrun/hello"

      resources {
        limits = {
          cpu    = "2"
          memory = "256Mi"
        }
        startup_cpu_boost = true
      }
    }
    max_instance_request_concurrency = 100
    scaling {
      min_instance_count = 1
      max_instance_count = 15
    }
  }

  traffic {
    type     = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent  = 100
    revision = "LATEST"
  }
}

resource "google_cloud_run_v2_service_iam_binding" "private_service_binding" {
  project  = var.project_id
  location = var.public_service_location
  name     = google_cloud_run_v2_service.public_service.name
  role     = "roles/run.invoker"
  members = [
    "user:rj.himanshu98@gmail.com",
  ]
}

