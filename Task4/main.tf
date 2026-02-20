terraform {
  required_version = ">= 1.5.7"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = var.docker_host
}

locals {
  project_prefix = "${var.project_name}-${var.environment}"
}

resource "docker_network" "app" {
  name = "${local.project_prefix}-net"
}

resource "docker_volume" "db_data" {
  name = "${local.project_prefix}-db-data"
}

resource "docker_image" "app" {
  name = "${local.project_prefix}-app:${var.app_image_tag}"

  build {
    context    = "${path.module}/app"
    dockerfile = "${path.module}/app/Dockerfile"
  }

  keep_locally = true
}

resource "docker_image" "postgres" {
  name = "postgres:${var.db_version}"
}

resource "docker_container" "db" {
  name  = "${local.project_prefix}-db"
  image = docker_image.postgres.image_id

  env = [
    "POSTGRES_DB=${var.db_name}",
    "POSTGRES_USER=${var.db_username}",
    "POSTGRES_PASSWORD=${var.db_password}",
  ]

  mounts {
    target = "/var/lib/postgresql/data"
    type   = "volume"
    source = docker_volume.db_data.name
  }

  networks_advanced {
    name = docker_network.app.name
  }

  ports {
    internal = 5432
    external = var.db_port
  }

  restart = "unless-stopped"
}

resource "docker_container" "app" {
  name  = "${local.project_prefix}-app"
  image = docker_image.app.image_id

  env = [
    "APP_PORT=${var.app_port}",
    "PROJECT_NAME=${var.project_name}",
    "ENVIRONMENT=${var.environment}",
    "DB_HOST=${var.db_host_override != null ? var.db_host_override : docker_container.db.name}",
    "DB_PORT=${var.db_port}",
    "DB_NAME=${var.db_name}",
    "DB_USER=${var.db_username}",
  ]

  networks_advanced {
    name = docker_network.app.name
  }

  ports {
    internal = var.app_port
    external = var.app_port
  }

  restart = "unless-stopped"

  depends_on = [docker_container.db]
}
