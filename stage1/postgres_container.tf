resource "docker_image" "postgres" {
  name = "postgres:12.0-alpine"
}

resource "random_string" "postgres_password" {
  length = 64
  special = false
}

resource "docker_container" "postgres" {
  name = "postgres"
  image = docker_image.postgres.latest

  networks_advanced {
    name = docker_network.vaulted.name
  }

  ports {
    internal = 5432
    external = 5432
  }

  env = ["POSTGRES_PASSWORD=${random_string.postgres_password.result}"]
}

output "postgres_password" {
  value = random_string.postgres_password.result
  sensitive = true
}
