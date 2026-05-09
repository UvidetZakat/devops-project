terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "postgres" {
  name = "postgres:15-alpine"
}

resource "docker_container" "postgres" {
  name  = "tf-postgres"
  image = docker_image.postgres.image_id

  ports {
    internal = 5432
    external = 5433
  }

  env = [
    "POSTGRES_USER=devops_user",
    "POSTGRES_PASSWORD=devops_pass",
    "POSTGRES_DB=devops_db"
  ]

  healthcheck {
    test     = ["CMD-SHELL", "pg_isready -U devops_user"]
    interval = "10s"
    timeout  = "5s"
    retries  = 5
  }
}

output "connection_string" {
  value     = "postgresql://devops_user:devops_pass@localhost:5432/devops_db"
  sensitive = true
}

output "container_name" {
  value = docker_container.postgres.name
}